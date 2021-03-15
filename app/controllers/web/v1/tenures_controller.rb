class Web::V1::TenuresController < ApplicationController
  before_action :set_tenure, only: [:show, :update, :destroy]

  # GET /web/v1/tenures
  # GET /web/v1/tenures.json
  def index
    @tenures = Tenure.all.order("updated_at DESC").order("created_at DESC")

    render json: @tenures
  end

  # GET /web/v1/tenures/1
  # GET /web/v1/tenures/1.json
  def show
    render json: @tenure
  end

  # POST /web/v1/tenures
  # POST /web/v1/tenures.json
  def create
    @tenure = Tenure.new(tenure_params)

    if @tenure.save
      audit(@tenure, current_user)
      render json: @tenure, status: :created
    else
      render json: @tenure.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/tenures/1
  # PATCH/PUT /web/v1/tenures/1.json
  def update
    @tenure = Tenure.find(params[:id])

    if @tenure.update(tenure_params)
      audit(@tenure, current_user)
      head :no_content
    else
      render json: @tenure.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/tenures/1
  # DELETE /web/v1/tenures/1.json
  def destroy
    audit(@tenure, current_user)
    @tenure.destroy
    

    head :no_content
  end

  def delete_tenures
    @tenures = params[:tenure_ids]
    @tenures.each do |tenure|
      Tenure.find(tenure).delete
    end
  end

  private

  def set_tenure
    @tenure = Tenure.find(params[:id])
  end

  def tenure_params
    params.require(:tenure).permit(:month)
  end
end
