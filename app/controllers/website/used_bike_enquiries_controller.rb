class Website::UsedBikeEnquiriesController < ApplicationController
  before_action :set_used_bike_enquiry, only: [:show, :update, :destroy]

  # GET /web/v1/used_bike_enquiries
  # GET /web/v1/used_bike_enquiries.json
  def index
    @used_bike_enquiries = UsedBikeEnquiry.all

    render json: @used_bike_enquiries
  end

  # GET /web/v1/used_bike_enquiries/1
  # GET /web/v1/used_bike_enquiries/1.json
  def show
    render json: @used_bike_enquiry
  end

  # POST /web/v1/used_bike_enquiries
  # POST /web/v1/used_bike_enquiries.json
  def create
    @used_bike_enquiry = UsedBikeEnquiry.new(used_bike_enquiry_params)

    if @used_bike_enquiry.save
      render json: @used_bike_enquiry, status: :created
       @used_bike_enquiry.used_car_enquiry_notification(I18n.t('Notification.used_bike_enquiry'), I18n.t('Email.used_bike_enquiry_dealer'), I18n.t('Email.used_bike_enquiry_user'), params)
    else
      render json: @used_bike_enquiry.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/used_bike_enquiries/1
  # PATCH/PUT /web/v1/used_bike_enquiries/1.json
  def update
    @used_bike_enquiry = UsedBikeEnquiry.find(params[:id])

    if @used_bike_enquiry.update(used_bike_enquiry_params)
      head :no_content
    else
      render json: @used_bike_enquiry.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/used_bike_enquiries/1
  # DELETE /web/v1/used_bike_enquiries/1.json
  def destroy
    @used_bike_enquiry.destroy

    head :no_content
  end

  private

    def set_used_bike_enquiry
      @used_bike_enquiry = UsedBikeEnquiry.find(params[:id])
    end

    def used_bike_enquiry_params
      params.require(:used_bike_enquiry).permit(:model, :email, :registration_number, :kms, :manufacture_year, :dealer_number, :price, :dealer_location, :comment, :name, :mobile, :address)
    end
end
