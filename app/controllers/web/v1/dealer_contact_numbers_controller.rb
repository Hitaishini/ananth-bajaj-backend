class Web::V1::DealerContactNumbersController < ApplicationController
  before_action :set_dealer_contact_number, only: [:show, :update, :destroy]

  # GET /web/v1/dealer_contact_numbers
  # GET /web/v1/dealer_contact_numbers.json
  def index
    @dealer_contact_numbers = DealerContactNumber.all.order("display_order")

    render json: @dealer_contact_numbers
  end

  # GET /web/v1/dealer_contact_numbers/1
  # GET /web/v1/dealer_contact_numbers/1.json
  def show
    render json: @dealer_contact_number
  end

  # POST /web/v1/dealer_contact_numbers
  # POST /web/v1/dealer_contact_numbers.json

  def create
    @dealer_contact_number = DealerContactNumber.new(dealer_contact_number_params)

    if @dealer_contact_number.save
      audit(@dealer_contact_number, current_user)
      render json: @dealer_contact_number, status: :created
    else
      render json: @dealer_contact_number.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/dealer_contact_numbers/1
  # PATCH/PUT /web/v1/dealer_contact_numbers/1.json
  def update
    @dealer_contact_number = DealerContactNumber.find(params[:id])

    if @dealer_contact_number.update(dealer_contact_number_params)
      audit(@dealer_contact_number, current_user)
      head :no_content
    else
      render json: @dealer_contact_number.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/dealer_contact_numbers/1
  # DELETE /web/v1/dealer_contact_numbers/1.json
  def destroy
    audit(@dealer_contact_number, current_user)
    @dealer_contact_number.destroy

    head :no_content
  end

  def delete_dealer_contact_numbers
   @dealer_contact_numbers = params[:dealer_contact_number_ids]
   @dealer_contact_numbers.each do |dealer_contact_number|
    DealerContactNumber.find(dealer_contact_number).delete
  end
end

private

def set_dealer_contact_number
  @dealer_contact_number = DealerContactNumber.find(params[:id])
end

def dealer_contact_number_params
  params.require(:dealer_contact_number).permit(:number, :dealer_id, :dealer_contact_label_id)
end
end
