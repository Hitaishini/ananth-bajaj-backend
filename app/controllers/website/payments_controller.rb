class Website::PaymentsController < ApplicationController
  before_action :set_payment, only: [:show, :update, :destroy]
  skip_before_filter :authenticate_user!
  # GET /payments
  # GET /payments.json
  def index
    @ser_payments = current_user.payments.where(entity_type: 'ServiceBooking')
    @insu = current_user.payments.where(entity_type: 'InsuranceRenewal')
    @payments = {"ServiceBooking": @ser_payments, "InsuranceRenewal": @insu}
    render json: @payments
  end


  # GET /payments/1
  # GET /payments/1.json
  def show
    render json: @payment
  end

  # POST /payments
  # POST /payments.json
  def create
    @payment = Payment.new(payment_params)
    merchant = Merchant.all.map { |f| f if f.dealer_id.include?(params[:payment][:dealer_id].to_i) && f.payment_for.include?(params[:payment][:entity_type]) }.compact.last
    @payment.merchant_id = merchant.id

    if @payment.save
      render json: @payment, status: :created
    else
      render json: @payment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /payments/1
  # PATCH/PUT /payments/1.json
  def update
    @payment = Payment.find(params[:id])
    update_history = payment_params[:status] && @payment.status != payment_params[:status]
    if @payment.update(payment_params)
      @payment.update_payment_history(payment_params[:status]) if update_history
      head :no_content
    else
      render json: @payment.errors, status: :unprocessable_entity
    end
  end

  def update_payment_after_pay
    @payment = Payment.find_by_txn_id(params[:txn_id])
    @payment.update_attributes(params) if @payment
    render json: @payment
  end  

  # DELETE /payments/1
  # DELETE /payments/1.json
  def destroy
    @payment.destroy

    head :no_content
  end

  def success
    @payment = Payment.find_by_txn_id(params[:txnid])
    logger.info "=====params value===========#{params.inspect}======="
    logger.info "============suceess================#{@payment.inspect}========status==================#{params.inspect}==============="
    @payment.update(mihpayid: params[:mihpayid],status: params[:status] ,txn_id: params[:txnid] ,amount: params[:amount] ,payuid: params[:payuMoneyId] ,phone: params[:phone]) if @payment
     update_payment_history(@payment)

    redirect_to "https://anantbajaj.com/#!/paymentdetail"
     
      split = @payment.delay(run_at: 10.minutes.from_now).payment_split(@payment, "error")
     logger.info "========#{split}=====responce for payment========#{@payment}====="

  end

  def error
    @payment = Payment.find_by_txn_id(params[:txnid])
    logger.info "============error================#{@payment.inspect}=============#{params.inspect}============================"
    @payment.update(mihpayid: params[:mihpayid],status: params[:status], txn_id: params[:txnid], amount: params[:amount] ,payuid: params[:payuMoneyId] ,phone: params[:phone]) if @payment
    update_payment_history(@payment)

    redirect_to "https://anantbajaj.com/#!/paymentdetail"
     
  end

  #create payment history on payment success/failure
 def update_payment_history(payment)
      #PaymentHistory.create(payment_id: payment.id, status: payment.status)  if payment 
      logger.info "=================#{payment.inspect}"
      payment.payment_notification(I18n.t('Notification.payment_success'), I18n.t('Email.payment_dealer'), I18n.t('Email.payment_success_user')) if payment.status == 'success'
      payment.payment_notification(I18n.t('Notification.payment_failed'), nil, nil) if payment.status == 'failure'
 end

  def pay_now
    logger.info "========#{params.inspect}=====input data============="
    payment = Payment.find params[:id]
    merchant = payment.merchant
    hash1 = payment.generate_hash
    product = []
    splited_acc_key = {"name":"#{merchant.name}", "merchantId ":"#{merchant.merchant_id}", "value":"#{payment.amount}", "commission":"0", "description":"split the amount to #{merchant.name}"}
    product << splited_acc_key
    product_info_key = {"paymentParts":product}

    res = {id: payment.id, hash: hash1, firstname: payment.user.profile.full_name, lastname:" ", surl: "https://anant-bajaj-dev.myridz.com/website/ok", furl: "https://anant-bajaj-dev.myridz.com/website/error", phone: payment.phone, key: merchant.merchant_key, txnid: payment.txn_id, productinfo: product_info_key.to_s, amount: payment.amount, email: payment.user.email }
    #service_provider: 'payu_paisa'
     logger.info "========#{res}=====responce============="

    render json: res
  end 

 

  private

    def set_payment
      @payment = Payment.find(params[:id])
    end

    def payment_params
      params.require(:payment).permit(:txn_id, :file_type, :user_id, :entity_type, :amount, :status, :merchant_id, :payment_type, :location, :vehicle_name, :bike_id, :mihpayid, :image, :payuid, :dealer_id, :phone, :booking_person_name, :payment_mode, :web_pay_image)
    end
end
