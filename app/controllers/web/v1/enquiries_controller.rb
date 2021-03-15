class Web::V1::EnquiriesController < ApplicationController
  before_action :set_enquiry, only: [:show, :update, :destroy]

  # GET /web/v1/enquiries
  # GET /web/v1/enquiries.json
  def index
    @enquiries = Enquiry.all.order("updated_at DESC").order("created_at DESC")

    render json: @enquiries
  end

  # GET /web/v1/enquiries/1
  # GET /web/v1/enquiries/1.json
  def show
    render json: @enquiry
  end

  # POST /web/v1/enquiries
  # POST /web/v1/enquiries.json
  def create
    @enquiry = Enquiry.new(enquiry_params)

    if @enquiry.save
      Notification.create(recipient: current_user, actor: current_user, action: I18n.t('Notification.contact_us'), notifiable: current_user)
      render json: @enquiry, status: :created
    else
      render json: @enquiry.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/enquiries/1
  # PATCH/PUT /web/v1/enquiries/1.json
  def update
    @enquiry = Enquiry.find(params[:id])

    if @enquiry.update(enquiry_params)
      head :no_content
    else
      render json: @enquiry.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @enquiry.destroy

    head :no_content
  end

  def delete_enquiries
    @enquiries = params[:enquiry_ids]
    @enquiries.each do |enquiry|
      Enquiry.find(enquiry).destroy
    end
  
  end


  private

    def set_enquiry
      @enquiry = Enquiry.find(params[:id])
    end

    def enquiry_params
      params.require(:enquiry).permit(:name, :dealer_location, :phone, :email, :category, :message, :bike)
    end
end
