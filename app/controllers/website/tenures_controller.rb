class Website::TenuresController < ApplicationController
  skip_before_filter :authenticate_user!
  before_action :set_tenure, only: [:show]

  # GET /web/v1/tenures
  # GET /web/v1/tenures.json
  def index
    @tenures = Tenure.all
    render json: @tenures
  end

  # GET /web/v1/tenures/1
  # GET /web/v1/tenures/1.json
  def show
    render json: @tenure
  end

  # POST /web/v1/tenures
  # POST /web/v1/tenures.json
 
  private

    def set_tenure
      @tenure = Tenure.find(params[:id])
    end

end
