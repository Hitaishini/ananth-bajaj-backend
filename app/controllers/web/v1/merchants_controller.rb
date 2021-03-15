class Web::V1::MerchantsController < ApplicationController
  before_action :set_merchant, only: [:show, :update, :destroy]

  # GET /merchants
  # GET /merchants.json
  def index
    @merchants = Merchant.all

    render json: @merchants
  end

  # GET /merchants/1
  # GET /merchants/1.json
  def show
    render json: @merchant
  end

  # POST /merchants
  # POST /merchants.json
  def create
    @merchant = Merchant.new(merchant_params)
    @merchant.payment_for = params[:merchant][:payment_for]
    @merchant.dealer_id = params[:merchant][:dealer_id]

    if @merchant.save
      render json: @merchant, status: :created
    else
      render json: @merchant.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /merchants/1
  # PATCH/PUT /merchants/1.json
  def update
    @merchant = Merchant.find(params[:id])

    if @merchant.update(merchant_params)
       @merchant.update(payment_for: params[:merchant][:payment_for], dealer_id: params[:merchant][:dealer_id])
       
      head :no_content
    else
      render json: @merchant.errors, status: :unprocessable_entity
    end
  end

  # DELETE /merchants/1
  # DELETE /merchants/1.json
  def destroy
    @merchant.destroy

    head :no_content
  end

  def delete_merchants
    @accessories = params[:merchant_ids]
    @accessories.each do |id|
      Merchant.find(id).delete
    end
  end

  private

    def set_merchant
      @merchant = Merchant.find(params[:id])
    end

    def merchant_params
      params.require(:merchant).permit(:merchant_id, :salt, :name, :location, :merchant_type, :merchant_key, :email, :mobile, :authorization, :payment_for, :dealer_id)
    end
end
