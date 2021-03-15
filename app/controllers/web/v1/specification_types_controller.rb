class Web::V1::SpecificationTypesController < ApplicationController
  before_action :set_specification_type, only: [:show, :update, :destroy]

  # GET /web/v1/specification_types
  # GET /web/v1/specification_types.json
  def index
    @specification_types = SpecificationType.all.order("display_order")

    render json: @specification_types, each_serializer: Web::V1::SpecificationTypeSerializer
  end

  # GET /web/v1/specification_types/1
  # GET /web/v1/specification_types/1.json
  def show
    render json: @specification_type, serializer: Web::V1::SpecificationTypeSerializer
  end

  # POST /web/v1/specification_types
  # POST /web/v1/specification_types.json
  def create
    @specification_type = SpecificationType.new(specification_type_params)

    if @specification_type.save
      audit(@specification_type, current_user)
      render json: @specification_type, status: :created, serializer: Web::V1::SpecificationTypeSerializer
    else
      render json: @specification_type.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/specification_types/1
  # PATCH/PUT /web/v1/specification_types/1.json
  def update
    @specification_type = SpecificationType.find(params[:id])

    if @specification_type.update(specification_type_params)
      audit(@specification_type, current_user)
      render json: @specification_type, status: :created, serializer: Web::V1::SpecificationTypeSerializer
    else
      render json: @specification_type.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/specification_types/1
  # DELETE /web/v1/specification_types/1.json
  def destroy
    audit(@specification_type, current_user)
    @specification_type.destroy

    head :no_content
  end

  def delete_specification_types
    @specification_types = params[:specification_type_ids]
    @specification_types.each do |specification_type|
      SpecificationType.find(specification_type).delete
    end
  end

  private

    def set_specification_type
      @specification_type = SpecificationType.find(params[:id])
    end

    def specification_type_params
      params.require(:specification_type).permit(:name, :display_order, :active)
    end
end
