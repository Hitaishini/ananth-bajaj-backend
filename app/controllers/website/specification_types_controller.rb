class Website::SpecificationTypesController < ApplicationController
  before_action :set_specification_type, only: [:show, :update, :destroy]

  # GET /mobile/v1/specification_types
  # GET /mobile/v1/specification_types.json
  def index
    @specification_types = SpecificationType.all.order("display_order")
    render json: @specification_types, each_serializer: Website::V1::SpecificationTypeSerializer
  end

  # GET /mobile/v1/specification_types/1
  # GET /mobile/v1/specification_types/1.json
  def show
    render json: @specification_type, serializer: Website::V1::SpecificationTypeSerializer
  end

  private

    def set_specification_type
      @specification_type = SpecificationType.find(params[:id])
    end


end