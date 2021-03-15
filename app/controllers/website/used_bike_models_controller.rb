class Website::UsedBikeModelsController < ApplicationController
  before_action :set_used_bike_model, only: [:show, :update, :destroy]

  # GET /web/v1/used_bike_models
  # GET /web/v1/used_bike_models.json
  def index
    @used_bike_models = UsedBikeModel.all

    render json: @used_bike_models
  end

  # GET /web/v1/used_bike_models/1
  # GET /web/v1/used_bike_models/1.json
  def show
    render json: @used_bike_model
  end

  # POST /web/v1/used_bike_models
  # POST /web/v1/used_bike_models.json
  def create
    @used_bike_model = UsedBikeModel.new(used_bike_model_params)

    if @used_bike_model.save
      render json: @used_bike_model, status: :created
    else
      render json: @used_bike_model.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/used_bike_models/1
  # PATCH/PUT /web/v1/used_bike_models/1.json
  def update
    @used_bike_model = UsedBikeModel.find(params[:id])

    if @used_bike_model.update(used_bike_model_params)
      head :no_content
    else
      render json: @used_bike_model.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/used_bike_models/1
  # DELETE /web/v1/used_bike_models/1.json
  def destroy
    @used_bike_model.destroy

    head :no_content
  end

  private

    def set_used_bike_model
      @used_bike_model = UsedBikeModel.find(params[:id])
    end

    def used_bike_model_params
      params.require(:used_bike_model).permit(:name)
    end
end
