class Web::V1::EmailNotificationTemplatesController < ApplicationController
  before_action :set_email_notification_template, only: [:show, :update, :destroy]

  # GET /web/v1/email_notification_templates
  # GET /web/v1/email_notification_templates.json
  def index
    @email_notification_templates = EmailNotificationTemplate.all.order("updated_at DESC").order("created_at DESC")

    render json: @email_notification_templates
  end

  # GET /web/v1/email_notification_templates/1
  # GET /web/v1/email_notification_templates/1.json
  def show
    render json: @email_notification_template
  end

  # POST /web/v1/email_notification_templates
  # POST /web/v1/email_notification_templates.json
  def create
    @email_notification_template = EmailNotificationTemplate.new(email_notification_template_params)

    if @email_notification_template.save
      render json: @email_notification_template, status: :created
    else
      render json: @email_notification_template.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/email_notification_templates/1
  # PATCH/PUT /web/v1/email_notification_templates/1.json
  def update
    @email_notification_template = EmailNotificationTemplate.find(params[:id])

    if @email_notification_template.update(email_notification_template_params)
      head :no_content
    else
      render json: @email_notification_template.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/email_notification_templates/1
  # DELETE /web/v1/email_notification_templates/1.json
  def destroy
    @email_notification_template.destroy

    head :no_content
  end

  def delete_email_notification_templates
    @email_notification_templates = params[:email_notification_template_ids]
    @email_notification_templates.each do |email_notification_template|
      EmailNotificationTemplate.find(email_notification_template).delete
    end
  end

  # def email_template_category
  #   @email_notification_template = EmailNotificationTemplate.pluck(:category)
  #   render json: @email_notification_template
  # end

  private

    def set_email_notification_template
      @email_notification_template = EmailNotificationTemplate.find(params[:id])
    end

    def email_notification_template_params
      params.require(:email_notification_template).permit(:content, :title, :category, :active)
    end
end
