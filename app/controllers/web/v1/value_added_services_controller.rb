class Web::V1::ValueAddedServicesController < ApplicationController
  before_action :set_value_added_service, only: [:show, :update, :destroy]

  # GET /web/v1/value_added_services
  # GET /web/v1/value_added_services.json
  def index
    @value_added_services = ValueAddedService.all

    render json: @value_added_services
  end

  # GET /web/v1/value_added_services/1
  # GET /web/v1/value_added_services/1.json
  def show
    render json: @value_added_service
  end

  # POST /web/v1/value_added_services
  # POST /web/v1/value_added_services.json
  def create
    @value_added_service = ValueAddedService.new(value_added_service_params)
     @value_added_service.select_scheme = params[:value_added_service][:select_scheme]

    if @value_added_service.save
      render json: @value_added_service, status: :created
    else
      render json: @value_added_service.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/value_added_services/1
  # PATCH/PUT /web/v1/value_added_services/1.json
  def update
    @value_added_service = ValueAddedService.find(params[:id])
    @value_added_service.select_scheme = params[:value_added_service][:select_scheme]

    if @value_added_service.update(value_added_service_params)
      head :no_content
    else
      render json: @value_added_service.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/value_added_services/1
  # DELETE /web/v1/value_added_services/1.json
  def destroy
    @value_added_service.destroy

    head :no_content
  end

  def delete_value_added_services
    @value_added_services = params[:value_added_ids]
    @value_added_services.each do |value|
      ValueAddedService.find(value).delete
    end
  end

  private

    def set_value_added_service
      @value_added_service = ValueAddedService.find(params[:id])
    end

    def value_added_service_params
      params.require(:value_added_service).permit(:name, :email, :registration_number, :mobile, :model, :date_of_purchase, :frame_number, :select_scheme, :description)
    end
end
