class Web::V1::NotificationTemplatesController < ApplicationController
  before_action :set_notification_template, only: [:show, :update, :destroy]

  # GET /web/v1/notification_templates
  # GET /web/v1/notification_templates.json
  def index
    @notification_templates = NotificationTemplate.all.order("updated_at DESC").order("created_at DESC")

    render json: @notification_templates
  end

  # GET /web/v1/notification_templates/1
  # GET /web/v1/notification_templates/1.json
  def show
    render json: @notification_template
  end

  # POST /web/v1/notification_templates
  # POST /web/v1/notification_templates.json
  def create
    @notification_template = NotificationTemplate.new(notification_template_params)

    if @notification_template.save
      render json: @notification_template, status: :created 
    else
      render json: @notification_template.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/notification_templates/1
  # PATCH/PUT /web/v1/notification_templates/1.json
  def update
    @notification_template = NotificationTemplate.find(params[:id])

    if @notification_template.update(notification_template_params)
      head :no_content
    else
      render json: @notification_template.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/notification_templates/1
  # DELETE /web/v1/notification_templates/1.json
  def destroy
    @notification_template.destroy

    head :no_content
  end

  def delete_notification_templates
     @notification_templates = params[:notification_template_ids]
    @notification_templates.each do |notification_template|
      NotificationTemplate.find(notification_template).delete
    end
  end

  private

    def set_notification_template
      @notification_template = NotificationTemplate.find(params[:id])
    end

    def notification_template_params
      params.require(:notification_template).permit(:content, :title, :category, :active)
    end
end
