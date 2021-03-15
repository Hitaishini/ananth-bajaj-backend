class Web::V1::KeyFeaturesController < ApplicationController
  before_action :set_key_feature, only: [:show, :update, :destroy]

  # GET /web/v1/key_features
  # GET /web/v1/key_features.json
  def index
    limit, offset = Calculator.limit_and_offset(params)
    @key_features = KeyFeature.all.limit(limit).offset(offset).order("updated_at DESC").order("created_at DESC")

    render json: @key_features
  end

  # GET /web/v1/key_features/1
  # GET /web/v1/key_features/1.json
  def show
    render json: @key_feature
  end

  # POST /web/v1/key_features
  # POST /web/v1/key_features.json
  def create
    @key_feature = KeyFeature.new(key_feature_params)

    if @key_feature.save
      audit(@key_feature, current_user)
      render json: @key_feature, status: :created
    else
      render json: @key_feature.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/key_features/1
  # PATCH/PUT /web/v1/key_features/1.json
  def update
    @key_feature = KeyFeature.find(params[:id])

    if @key_feature.update(key_feature_params)
      audit(@key_feature, current_user)
      head :no_content
    else
      render json: @key_feature.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/key_features/1
  # DELETE /web/v1/key_features/1.json
  def destroy
    audit(@key_feature, current_user)
    @key_feature.destroy

    head :no_content
  end

  def delete_key_features
    @key_features = params[:key_feature_ids]
    @key_features.each do |key_feature|
      KeyFeature.find(key_feature).delete
    end
  end

 

  private

    def set_key_feature
      @key_feature = KeyFeature.find(params[:id])
    end

    def key_feature_params
      params.require(:key_feature).permit(:title, :description, :image, :bike_id, :key_feature_type_id, :active, :varient_id)
    end
end
