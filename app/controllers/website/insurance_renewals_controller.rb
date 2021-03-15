class Website::InsuranceRenewalsController < ApplicationController
  before_action :set_insurance_renewal, only: [:show, :update, :destroy]
 
  def show
    render json: @insurance_renewal
  end

  # POST /web/v1/insurance_renewals
  # POST /web/v1/insurance_renewals.json
  def create
    my_bike = MyBike.find(params[:insurance_renewal][:my_bike_id])
    @insurance_renewal = InsuranceRenewal.new(insurance_renewal_params)
    @insurance_renewal.bike = my_bike.bike

    if @insurance_renewal.save
      render json: @insurance_renewal, status: :created
      @insurance_renewal.send_insurance_notification
    else
      render json: @insurance_renewal.errors, status: :unprocessable_entity
    end
  end

  private

    def set_insurance_renewal
      @insurance_renewal = InsuranceRenewal.find(params[:id])
    end

    def insurance_renewal_params
      params.require(:insurance_renewal).permit(:name, :email, :mobile, :address, :bike, :purchase_date, :registration_number, :insurance_company, :policy_number, :expiry_date, :engine_number, :kms)
    end
end
