class Web::V1::PaymentsController < ApplicationController
  before_action :set_payment, only: [:show, :update, :destroy]

  # GET /payments
  # GET /payments.json
  def index
    @payments = Payment.all.order("updated_at ASC").order("created_at ASC")   

    render json: @payments
  end

  #brand payments
  def brand_payments
     @payments = Payment.where(dealer_brand: params[:brand]).order("updated_at ASC").order("created_at ASC")   

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
    @payment.status = "Created"
    #@payment.requested_from = "Admin"
    @payment.phone = User.find_by_id(params[:payment][:user_id]).try(:profile).try(:mobile)

    if @payment.save
      @payment.payment_notification(I18n.t('Notification.payment'), nil, I18n.t('Email.payment_user'))
      render json: @payment, status: :created
    else
      render json: @payment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /payments/1
  # PATCH/PUT /payments/1.json
  def update
    @payment = Payment.find(params[:id])
    if payment_params[:status] && @payment.status != payment_params[:status]
      @payment.update_payment_history(payment_params[:status])
    end
      
    if @payment.update(payment_params)
      @payment.delay.payment_notification(I18n.t('Notification.payment_update'), nil, I18n.t('Email.payment_update')) #if @payment.status == 'Generated'
      @payment.payment_notification(nil, nil, I18n.t('Email.payment_update')) #if @payment.status == 'success'
      @payment.payment_notification(I18n.t('Notification.payment_failed'), nil, nil) if @payment.status == 'failure'
      head :no_content
    else
      render json: @payment.errors, status: :unprocessable_entity
    end
  end

  def refund_payment_api
    @payment = Payment.find(params[:id]).dup
    Payment.skip_callback(:create, :after, :generate_txn_id)
    @payment.status = 'RefundInitiated'
    @payment.amount = params[:amount]
    if @payment.save

      Payment.set_callback(:create, :after, :generate_txn_id)
      @payment.assign_car_model
      res, mes, refund_id = @payment.refund_payment
      @payment.update(message: mes)
      if res == 0 
        @payment.update(refund: true, refund_id: refund_id)
        PaymentHistory.create(payment_id: @payment.id, status: 'RefundInitiated')
        @payment.delay.payment_notification(I18n.t('Notification.payment_refund_initiat'), I18n.t('Email.payment_refund_initiat_dealer'), I18n.t('Email.payment_refund_initiat_user'))
      else
        @payment == @payment.update(status: 'RefundFailed')
        PaymentHistory.create(payment_id: @payment.id, status: 'RefundFailed')
        #@payment.payment_notification(nil, I18n.t('Email.payment_refund_initiat_dealer'), I18n.t('Email.payment_refund_initiat_user'))
      end  
      
      render json: {message: mes}
    else
      render json: @payment.errors, status: :unprocessable_entity
    end
  end  

  #refund and cancel payments apis
  def resend_and_cancel_payments
    payment = Payment.find_by_id(params[:id])
     if params[:resend] == true
        template = NotificationTemplate.where(category: I18n.t('Notification.payment')).last
         Notification.create(recipient: payment.user, actor: payment.user, action: 'Payment', notifiable: payment, notification_template: template)
             # mail to confirm user
         UserMailer.delay.payment_mail(payment, I18n.t('Email.payment_user'), 'User')
     else
       payment.update(status: "failed")
       UserMailer.delay.resend_cancel_email(payment, "Payment-due-cancel")
     end
  end

  # DELETE /payments/1
  # DELETE /payments/1.json
  def destroy
    @payment.destroy

    head :no_content
  end

   def mybikes_with_user
    user = User.find_by_id(params[:user_id])
    logger.info "=====#{user.inspect}========"
    @my_bikes = user.my_bikes

    render json: @my_bikes
  end


  def get_entity_data
    res = {"data": (params["entity_type"].constantize).where("user_id = ? and status <> ?", params["user_id"], 'Paid')}
    render json: res  
  end 

  def payment_bike_details
    bikes = Bike.all

    render json: bikes, each_serializer: Web::V1::BikeDetailSerializer 
  end


  private

    def set_payment
      @payment = Payment.find(params[:id])
    end

    def payment_params
      params.require(:payment).permit(:txn_id, :file_type, :user_id, :entity_type, :amount, :status, :merchant_id, :payment_type, :location, :vehicle_name, :bike_id, :mihpayid, :image, :payuid, :dealer_id, :phone, :booking_person_name, :payment_mode, :web_pay_image)
    end
end
