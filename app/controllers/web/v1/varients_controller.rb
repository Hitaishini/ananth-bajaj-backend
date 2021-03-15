class Web::V1::VarientsController < ApplicationController
  before_action :set_varient, only: [:show, :update, :destroy]

  # GET /web/v1/varients
  # GET /web/v1/varients.json
  def index
    @varients = Varient.all

    render json: @varients
  end

  # GET /web/v1/varients/1
  # GET /web/v1/varients/1.json
  def show
    render json: @varient
  end

  # POST /web/v1/varients
  # POST /web/v1/varients.json
  def create
    @varient = Varient.new(varient_params)

    if @varient.save
      audit(@varient, current_user)
      render json: @varient, status: :created
    else
      render json: @varient.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/varients/1
  # PATCH/PUT /web/v1/varients/1.json
  def update
    @varient = Varient.find(params[:id])

    if @varient.update(varient_params)
      audit(@varient, current_user)
      head :no_content
    else
      render json: @varient.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/varients/1
  # DELETE /web/v1/varients/1.json
  def destroy
    audit(@varient, current_user)
    @varient.destroy

    head :no_content
  end

  def delete_varients
  @varient = params[:varient_ids]
  @varient.each do |varient|
    Varient.find(varient).delete
  end
end

  private

    def set_varient
      @varient = Varient.find(params[:id])
    end

    def varient_params
      params.require(:varient).permit(:varient_name, :fuel_type, :transmission_type, :bike_id, :cc, :gear, :mileage, :visible)
    end
end
