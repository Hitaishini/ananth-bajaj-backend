class Website::DealersController < ApplicationController
  before_action :set_dealer, only: [:show]
  skip_before_filter :authenticate_user!

  # GET /web/v1/dealers
  # GET /web/v1/dealers.json
  def index
    @dealers = Dealer.all.order("service_display_order")

    render json: @dealers
  end

  # GET /web/v1/dealers/1
  # GET /web/v1/dealers/1.json
  def show
    render json: @dealer
  end

  def dealer_contact_numbers
    @dealer = Dealer.all
    @dealer_contact_number = DealerContactNumber.joins(:dealer)
   
    render json: @dealer_contact_number
  end

  def get_dealer_contact_numbers_by_dealer_name
    @dealers = DealerContactNumber.joins(:dealer).where("dealers.dealer_name =?",params[:dealer_name])
    render json: @dealers
  end

  def dealers_with_type
    dealer_type_ids = DealerType.where(dealer_type: params[:type]).pluck(:id).join
    dealer = []
    Dealer.all.each do |f|
      if f.dealer_type_id.join(',').split(',').include? dealer_type_ids
        dealer << f
      end
    end
    render json: dealer
  end

  def find_dealers
    @dealer_types = Dealer.includes(:dealer_types).where(dealer_types: { dealer_type: params[:type]})
    @dealer_location = Dealer.where("dealer_name in (?)", params[:location])
    begin
      if params[:type] && params[:location]
        @dealer = @dealer_types.where("dealer_name in (?)", params[:location])
      elsif params[:type] && params[:location].nil?
        @dealer = @dealer_types
      elsif params[:type].nil? && params[:location]
        @dealer = @dealer_location
      else
        @dealer = Dealer.all
      end
    rescue
      "No Dealers"
    end

    render json: @dealer
  end

  # POST /web/v1/dealers


  private

  def set_dealer
    @dealer = Dealer.find(params[:id])
  end

end
