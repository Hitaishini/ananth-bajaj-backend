 class Web::V1::SpecificationsController < ApplicationController
  before_action :set_specification, only: [:show, :update, :destroy]

  # GET /web/v1/specifications
  # GET /web/v1/specifications.json
  def index
    limit, offset = Calculator.limit_and_offset(params)
    @specifications = Specification.all.limit(limit).offset(offset).order("updated_at DESC").order("created_at DESC")

    render json: @specifications, each_serializer: Web::V1::SpecificationSerializer
  end

  # GET /web/v1/specifications/1
  # GET /web/v1/specifications/1.json
  def show
    render json: @specification, serializer: Web::V1::SpecificationSerializer
  end

  # POST /web/v1/specifications
  # POST /web/v1/specifications.json
  def create
    @specification = Specification.new(specification_params)

    if @specification.save
      audit(@specification, current_user)
      render json: @specification, status: :created, serializer: Web::V1::SpecificationSerializer
    else
      render json: @specification.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/specifications/1
  # PATCH/PUT /web/v1/specifications/1.json
  def update
    if @specification.update(specification_params)
      audit(@specification, current_user)
      render json: @specification, status: :ok, serializer: Web::V1::SpecificationSerializer
    else
      render json: @specification.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/specifications/1
  # DELETE /web/v1/specifications/1.json
  def destroy
    audit(@specification, current_user)
    @specification.destroy

    head :no_content
  end

  def delete_specifications
    @specifications = params[:specification_ids]
    @specifications.each do |specification|
      Specification.find(specification).delete
    end
  end

  private

    def set_specification
      @specification = Specification.find(params[:id])
    end

    def specification_params
      params.require(:specification).permit(:name, :specification_type_id, :bike_id, :value, :active, :compare_visible, :specification_name_id)
    end
end