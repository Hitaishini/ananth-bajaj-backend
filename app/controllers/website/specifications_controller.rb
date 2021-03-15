class Website::SpecificationsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_specification, only: [:show]

  # GET /mobile/v1/specifications
  # GET /mobile/v1/specifications.json
  def index
    @specifications = Specification.all

    render json: @specifications, each_serializer: Website::V1::SpecificationSerializer
  end

  # GET /mobile/v1/specifications/1
  # GET /mobile/v1/specifications/1.json
  def show
    render json: @specification, serializer: Website::V1::SpecificationSerializer
  end

  private

    def set_specification
      @specification = Specification.find(params[:id])
    end

end