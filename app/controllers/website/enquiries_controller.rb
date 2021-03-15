class Website::EnquiriesController < ApplicationController
  skip_before_filter :authenticate_user!

  # POST /web/v1/enquiries
  # POST /web/v1/enquiries.json
  def create
    @enquiry = Enquiry.new(enquiry_params)

    if @enquiry.save
      render json: @enquiry, status: :created
      template = NotificationTemplate.where(category: I18n.t('Notification.contact_us')).last
      Notification.create(recipient: current_user, actor: current_user, action: 'Offer', notifiable: @enquiry, notification_template: template)
      UserMailer.delay.contact_us(@enquiry)
      UserMailer.delay.contact_us_user(@enquiry)
      
    else
      render json: @enquiry.errors, status: :unprocessable_entity
    end
  end

  private

    def enquiry_params
      params.require(:enquiry).permit(:name, :phone, :email, :dealer_location, :category, :message, :bike)
    end
end
