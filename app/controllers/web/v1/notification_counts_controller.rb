class Web::V1::NotificationCountsController < ApplicationController
  before_action :set_notification_count, only: [:show, :update, :destroy]

  # GET /notification_counts
  # GET /notification_counts.json
  def index
    @notification_counts = NotificationCount.all

    render json: @notification_counts
  end

  # GET /notification_counts/1
  # GET /notification_counts/1.json
  def show
    render json: @notification_count
  end

  # POST /notification_counts
  # POST /notification_counts.json
  def create
    @notification_count = NotificationCount.new(notification_count_params)

    if @notification_count.save
      render json: @notification_count, status: :created, location: @notification_count
    else
      render json: @notification_count.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /notification_counts/1
  # PATCH/PUT /notification_counts/1.json
  def update
    @notification_count = NotificationCount.find(params[:id])

    if @notification_count.update(notification_count_params)
      head :no_content
    else
      render json: @notification_count.errors, status: :unprocessable_entity
    end
  end

  # DELETE /notification_counts/1
  # DELETE /notification_counts/1.json
  def destroy
    @notification_count.destroy

    head :no_content
  end

  def delete_notification_counts
    @notification_counts = params[:notification_count_ids]
    @notification_counts.each do |notification_count|
      NotificationCount.find(notification_count).delete
    end
  end

  private

  def set_notification_count
    @notification_count = NotificationCount.find(params[:id])
  end

  def notification_count_params
    params.require(:notification_count).permit(:user_id, :test_drive_count, :offer_count, :insurance_count, :service_count, :tips)
  end
end
