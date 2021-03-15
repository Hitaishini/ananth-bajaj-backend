class Web::V1::EmailPriceListsController < ApplicationController
  before_action :set_email_price_list, only: [:show, :update, :destroy]

  # GET /web/v1/email_price_lists
  # GET /web/v1/email_price_lists.json
  def index
    @email_price_lists = EmailPriceList.where(category: nil).order("updated_at DESC")

    render json: @email_price_lists , each_serializer: Web::V1::EmailPriceSerializer
  end

  #get all price charts
  def get_price_chart
    @price_charts = EmailPriceList.where(category: "Price Chart").order("updated_at DESC")

    render json: @price_charts , each_serializer: Web::V1::EmailPriceSerializer
  end

  # GET /web/v1/email_price_lists/1
  # GET /web/v1/email_price_lists/1.json
  def show
    render json: @email_price_list
  end

  # POST /web/v1/email_price_lists
  # POST /web/v1/email_price_lists.json
  def create
    @email_price_list = EmailPriceList.new(email_price_list_params)

    if @email_price_list.save
      render json: @email_price_list, status: :created
    else
      render json: @email_price_list.errors, status: :unprocessable_entity
    end
  end



  # PATCH/PUT /web/v1/email_price_lists/1
  # PATCH/PUT /web/v1/email_price_lists/1.json
  def update
    @email_price_list = EmailPriceList.find(params[:id])

    if @email_price_list.update(email_price_list_params)
      head :no_content
    else
      render json: @email_price_list.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/email_price_lists/1
  # DELETE /web/v1/email_price_lists/1.json
  def destroy
    @email_price_list.destroy

    head :no_content
  end

  #for deleting all
  def delete_price_lists
    @email_price_lists = params[:price_list_ids]
    @email_price_lists.each do |price|
      EmailPriceList.find(price).delete
    end
  end

  #for admin filter case
  def email_price_filter
    email_price_list = EmailPriceList.admin_search(params)

    render json: email_price_list
  end

  private

    def set_email_price_list
      @email_price_list = EmailPriceList.find(params[:id])
    end

    def email_price_list_params
      params.require(:email_price_list).permit(:name, :email, :mobile, :varient_id, :manufacturer, :followed_up, :comments, :category)
    end
end
