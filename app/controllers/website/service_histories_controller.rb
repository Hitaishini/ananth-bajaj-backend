class Website::ServiceHistoriesController < ApplicationController
  before_action :set_service_history, only: [:show, :update, :destroy]
  
  # GET /web/v1/service_histories
  # GET /web/v1/service_histories.json
  # def index
  #   @service_histories = ServiceHistory.all

  #   render json: @service_histories
  # end

  # # GET /web/v1/service_histories/1
  # # GET /web/v1/service_histories/1.json
  def show
    render json: @service_history
  end

  # POST /web/v1/service_histories
  # POST /web/v1/service_histories.json
  def create
    @service_history = ServiceHistory.new(service_history_params)

    if @service_history.save
      render json: @service_history, status: :created
    else
      render json: @service_history.errors, status: :unprocessable_entity
    end
  end

   def validate_service_histories
     my_bike = MyBike.find_by_id(params[:service_history][:my_bike_id])
    if my_bike.service_histories.where(document_name: params[:service_history][:document_name]).any?
      render :json => { :message => "document name is already there", :status => 422 }.to_json
    else
      render :json => { :status => 200 }
    end
  end

  # PATCH/PUT /web/v1/service_histories/1
  # PATCH/PUT /web/v1/service_histories/1.json
  def update
    @service_history = ServiceHistory.find(params[:id])

    if @service_history.update(service_history_params)
      head :no_content
    else
      render json: @service_history.errors, status: :unprocessable_entity
    end
  end

  def service_history_image_update
    @service_history = ServiceHistory.find(params[:id])
    @service_history.remove_bill_image! if @service_history.bill_image

    if @service_history.update(service_history_params)
      @service_history.bill_image = params[:service_history][:bill_image]
       @service_history.save
      render json: @service_history
      #head :no_content
    else
      render json: @service_history.errors, status: :unprocessable_entity
    end
  end

  def get_my_bike_service_histories
    @my_bike = MyBike.find(params[:my_bike_id])
    @service_histories = @my_bike.service_histories
     render json: @service_histories
  end

  # DELETE /web/v1/service_histories/1
  # DELETE /web/v1/service_histories/1.json
  def destroy
    @service_history.destroy

    head :no_content
  end

  

  def get_ride_status
    @user_ride = UserRide.where('ride_id = ? AND perticipate_ride = ?', params[:ride_id], params[:status])

    render json: @user_ride, root: "rides status"
  end

  def get_event_status
    @user_ride = UserEvent.where('event_id = ? AND perticipate_event = ?', params[:event_id], params[:status])

    render json: @user_ride, root: "events status"
  end



  private

    def set_service_history
      @service_history = ServiceHistory.find(params[:id])
    end

    def service_history_params
      params.require(:service_history).permit(:service_date, :service_type, :kms, :total_cost, :my_bike_id, :bill_image, :document_name, :file_type)
    end
end
