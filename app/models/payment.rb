require 'net/http'
require 'openssl'
require "net/https"
require "uri"

class Payment < ApplicationRecord
	belongs_to :entity, polymorphic: true
	belongs_to :user
	belongs_to :merchant
	belongs_to :dealer
	has_many :payment_histories
	#after_create :payment_notification
	after_create :generate_txn_id
	#assigning car model name
	before_save :assign_car_model
    mount_base64_uploader :image, MyDocUploader, file_name: 'payment'
	mount_base64_uploader :web_pay_image, PaymentUploader, file_name: 'payment'


def payment_notification(n_template, dealer_mail_template, customer_mail_template)
	logger.info "===Payment Notification===="
	user = self.user
	template = NotificationTemplate.where(category: n_template).last
	Notification.create(recipient: user, actor: user, action: 'Payment', notifiable: self, notification_template: template) if n_template
      # mail to admin
    UserMailer.delay.payment_mail(self, dealer_mail_template, 'Dealer') if dealer_mail_template
       # mail to confirm user
    UserMailer.delay.payment_mail(self, customer_mail_template, 'User') if customer_mail_template
end

 #create new transaction id on payment create/update
 def generate_txn_id
 	t_id = nil
 	loop do	
 		num = Random.new.rand(0..999999)
 		t_id = "Anant_" + self.merchant.merchant_type + "_" + num.to_s  #self.merchant.location +
 		break unless Payment.exists?(txn_id: t_id)
 	end
 	Payment.skip_callback(:create, :after, :generate_txn_id)
 	self.txn_id = t_id.to_s
 	self.save
 	Payment.set_callback(:create, :after, :generate_txn_id)
 end	

#link car model to payment
 def assign_car_model
 	bike = (self.entity_type == "Booking down-payment" || self.entity_type == "Other") ? Bike.find_by_id(self.bike_id).try(:name) :  MyBike.find_by_id(self.bike_id).try(:bike)
 	self.vehicle_name = bike if bike
 end	

# generates hash on pay_now
 def generate_hash
 	product = []
    splited_acc_key = {"name":"#{self.merchant.name}", "merchantId ":"#{self.merchant.merchant_id}", "value":"#{self.amount}", "commission":"0", "description":"split the amount to #{self.merchant.name}"}
    product << splited_acc_key
    product_info_key = {"paymentParts":product}
 	hash_string = "#{self.merchant.merchant_key.to_s}|#{self.txn_id.to_s}|#{self.amount.to_s}|#{product_info_key.to_s}|#{self.user.profile.full_name.to_s}|#{self.user.email}|||||||||||#{self.merchant.salt.to_s}"
 	logger.info "================#{hash_string}========="																
 	Digest::SHA2.new(512).hexdigest(hash_string)
 end	

#create payment history on payment success/failure
 def update_payment_history(status)
 	PaymentHistory.create(payment_id: self.id, status: status)
 	logger.info "=================#{self.inspect}"
 	payment_notification(I18n.t('Notification.payment_success'), I18n.t('Email.payment_dealer'), I18n.t('Email.payment_success_user')) if self.status == 'success'
  payment_notification(I18n.t('Notification.payment_failed'), nil, nil) if self.status == 'failure'
     
 	self.generate_txn_id if status == 'failure'
 end

 def refund_payment
  mrcht = self.merchant
  uri = URI.parse("https://www.payumoney.com/payment/refund/refundPayment?paymentId=#{self.child_payment_id}&refundAmount=#{self.amount.to_i}&refundType=1&merchantId=#{mrcht.merchant_id}&merchantAmount=#{self.amount.to_i}&aggregatorAmount=0")

  logger.info uri
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  request = Net::HTTP::Post.new(uri.request_uri)
  request['Authorization'] = mrcht.authorization
  response = http.request(request)
  res = JSON[response.body]
  
  logger.info "==anil kumar===#{res}======="
  return res["status"], res["message"], res["result"]
 end

 def payment_split(payment, split_message)
 	status = payment.payment_transection_status(payment)
    logger.info "=====#{status}===="
      c = 20
      if status == "Money with Payumoney"
      	logger.info "=====#{status}======response mathcing====="
		 payment.split_process_action(payment)
	  else
	  	logger.info "====#{status}====wrong response====#{payment}=="
	  	if split_message == "error"
		  	while c <= 50 do 
			  	payment.delay(run_at: c.minutes.from_now).payment_split(payment, "failed")
			  	logger.info "===#{c}====count value===="
			  	if c == 50
			  		logger.info "===#{c}======#{status}===sending email admin===="
			  		payment.update(status: status)
			  		UserMailer.delay.payment_failed_status(payment)
			  	end
			  	c += 30
			end
		end
	  end
 end	

 def split_process_action(payment)
 	 mrcht = payment.merchant
	  json_array = [{merchantId: "#{mrcht.merchant_id}", splitAmount: "#{payment.amount.to_i}", aggregatorSubTransactionId: "#{payment.mihpayid}", aggregatorCharges: "0", aggregatorDiscount: "0", sellerDiscount: "0", CODAmount: "0", CODMode: "1",splitDetails: "SOME_SPLIT", amountToBeSettled: "#{payment.amount.to_i}"}]
	  
	  some = "merchantKey=#{mrcht.merchant_key}&merchantTransactionId=#{payment.txn_id}&totalAmount=#{payment.amount.to_i}&totalDiscount=0&jsonSplits=#{json_array.to_s}"

	 ss_split = some.delete("\"").gsub(':', '').gsub('=>', '=').delete(' ')
	 uri = URI.parse("https://www.payumoney.com/payment/payment/addPaymentSplit?#{ss_split}")
	 logger.info "==anil kumar===#{uri}=========="

	  logger.info uri
	  http = Net::HTTP.new(uri.host, uri.port)
	  http.use_ssl = true
	  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
	  request = Net::HTTP::Post.new(uri.request_uri)
	  request['Authorization'] = mrcht.authorization  #authorization:
	  request['Content-Type'] = 'application/json'
	  response = http.request(request)
	   logger.info "=====#{response}=============="

	  res = JSON[response.body]	
	  logger.info "=====#{res}=============="
	  if res
	  	payment.update(split_status: res["message"])
	  	if res["result"]
	  	  payment.update(split_payment_id: res["result"]["paymentId"], child_payment_id: res["result"]["splitIdMap"]["#{payment.mihpayid}"]) 
	  	  release = payment.release_split_amount(payment)
	      logger.info "=====#{release}===release payment=====#{payment}====kumar="
	    end
	  end

	  return res
 end


 def release_split_amount(payment)
 	 mrcht = payment.merchant

     uri = URI.parse("https://www.payumoney.com/payment/merchant/releasePayment?paymentId=#{payment.split_payment_id}&merchantId=#{mrcht.merchant_id}")
	 logger.info "==anil kumar===#{uri}=========="

	  logger.info uri
	  http = Net::HTTP.new(uri.host, uri.port)
	  http.use_ssl = true
	  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
	  request = Net::HTTP::Post.new(uri.request_uri)
	  request['Authorization'] = mrcht.authorization  #authorization:
	  request['Content-Type'] = 'application/json'
	  response = http.request(request)
       logger.info "=====#{response}=============="

	  res = JSON[response.body]	
	  if res
	  	payment.update(release_status: res["message"])
	  end
	  logger.info "=====#{res}=============="
	  return res
 end

 def payment_transection_status(payment)
 	  mrcht = payment.merchant
	    uri = URI.parse("https://www.payumoney.com/payment/payment/chkMerchantTxnStatus?merchantKey=#{mrcht.merchant_key}&merchantTransactionIds=#{payment.txn_id}")
	  http = Net::HTTP.new(uri.host, uri.port)
	  http.use_ssl = true
	  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
	  request = Net::HTTP::Post.new(uri.request_uri)
	  request['Authorization'] = mrcht.authorization#{}"KwWf1qh0FmwCOT//sOTTwVLOwbdjQ0RiMDRTJZinqvc="
	  response = http.request(request)
	  puts response.body
	  puts response.code

	  res = JSON[response.body]

	   return res["result"][0]["status"]
  end

 def self.refund_payment_status_check
 	Payment.where(status: ['RefundInitiated', 'refundinprogress']).uniq.each do |payment|
 		if payment
 			mrcht = payment.merchant
		    uri = URI.parse("https://www.payumoney.com/payment/payment/chkMerchantTxnStatus?merchantKey=#{mrcht.merchant_key}&merchantTransactionIds=#{payment.txn_id}")
		  http = Net::HTTP.new(uri.host, uri.port)
		  http.use_ssl = true
		  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
		  request = Net::HTTP::Post.new(uri.request_uri)
		  request['Authorization'] = mrcht.authorization#{}"KwWf1qh0FmwCOT//sOTTwVLOwbdjQ0RiMDRTJZinqvc="
		  response = http.request(request)
		  puts response.body
		  puts response.code

		  res = JSON[response.body]
		  pay_status = res["result"][0]["status"] if res["result"] 
			  if pay_status == "Fully Refunded" || pay_status == "Partially Refunded"
		  		payment.update(status: pay_status)
		  		PaymentHistory.create(payment_id: @payment.id, status: 'RefundSuccess') if pay_status == "Fully Refunded"
		  		payment.payment_notification(I18n.t('Notification.payment_refund_success'), I18n.t('Email.payment_refund_success_dealer'), I18n.t('Email.payment_refund_success_user')) if pay_status == "Fully Refunded"
			  end  	
	    end  
	end	
 end	

#JSON responce modifiers

	def user_name
		self.user.try(:profile).try(:full_name)
	end

	def email_user
		self.user.try(:email)
	end

	def merchant_name
		self.merchant.try(:name)
	end

	def merchant_type
		self.merchant.try(:merchant_type)
	end

	def merchant_location
		self.merchant.try(:location)
	end

	def payment_history_image
		self.image.url ? ("https://anant-bajaj-dev.myridz.com" + self.image.url) : nil
	end	

	def pay_dealer_name
		self.dealer.try(:dealer_name)
	end

    def payment_created_at
 	   self.created_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M %p')
    end	

    def payment_updated_at
    	self.updated_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M %p')
    end

    def reg_number
    	MyBike.find_by_bike_and_user_id("#{self.vehicle_name}","#{self.user_id}").try(:registration_number)
    end

	def as_json(options={})
    super.as_json(options).merge({:user_name => user_name, :user_mail => email_user, :merchant_name => merchant_name, :merchant_type => merchant_type, :merchant_location => merchant_location, :image => payment_history_image, dealer_name: pay_dealer_name, created_at: payment_created_at ,updated_at: payment_updated_at,reg_no: reg_number})
  end
end
