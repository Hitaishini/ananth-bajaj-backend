class Web::V1::ServiceHistoriesController < ApplicationController
  before_action :set_service_history, only: [:show, :update, :destroy]

  # GET /web/v1/service_histories
  # GET /web/v1/service_histories.json
  def index
    @service_histories = ServiceHistory.all.order("updated_at DESC").order("created_at DESC")

    render json: @service_histories
  end

  # GET /web/v1/service_histories/1
  # GET /web/v1/service_histories/1.json
  def show
    render json: @service_history
  end

  # POST /web/v1/service_histories
  # POST /web/v1/service_histories.json
  def create
    @service_history = ServiceHistory.new(service_history_params)

    if @service_history.save
      audit(@service_history, current_user)
      render json: @service_history, status: :created
    else
      render json: @service_history.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/service_histories/1
  # PATCH/PUT /web/v1/service_histories/1.json
  def update
    @service_history = ServiceHistory.find(params[:id])

    if @service_history.update(service_history_params)
      audit(@service_history, current_user)
      head :no_content
    else
      render json: @service_history.errors, status: :unprocessable_entity
    end
  end

  def update_service_history_image
   @service_history = ServiceHistory.find(params[:id])
   @service_history.remove_bill_image! if @service_history.bill_image

   if @service_history.update(service_history_params)
     @service_history.bill_image = params[:service_history][:bill_image]
     @service_history.save
     render json: @service_history
      #head :no_content
    else
      render json: @service_history.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/service_histories/1
  # DELETE /web/v1/service_histories/1.json
  def destroy
    audit(@service_history, current_user)
    @service_history.destroy

    head :no_content
  end

  def delete_service_histories
    @service_histories = params[:service_histories_ids]
    @service_histories.each do |service_histories|
      ServiceHistory.find(service_histories).delete
    end
  end

  private

  def set_service_history
    @service_history = ServiceHistory.find(params[:id])
  end

  def service_history_params
    params.require(:service_history).permit(:service_date, :service_type, :kms, :total_cost, :my_bike_id, :bill_image)
  end
end
