class Website::FeedbacksController < ApplicationController
  skip_before_filter :authenticate_user!

  # POST /web/v1/feedbacks
  # POST /web/v1/feedbacks.json
  def create
    @feedback = Feedback.new(feedback_params)

    if @feedback.save
      render json: @feedback, status: :created
      #template = NotificationTemplate.where(category: I18n.t('Notification.feedback')).last
      #Notification.create(recipient: current_user, actor: current_user, action: 'Offer', notifiable: @feedback, notification_template: template)
      UserMailer.delay.feedback(@feedback)
      
    else
      render json: @feedback.errors, status: :unprocessable_entity
    end
  end

  private

    def feedback_params
      params.require(:feedback).permit(:name, :email, :mobile, :feedback_type, :comment, :rating, :dealer_location)
    end
end
