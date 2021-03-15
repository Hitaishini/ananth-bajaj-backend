class Web::V1::SpecificationNamesController < ApplicationController
  before_action :set_specification_name, only: [:show, :update, :destroy]

  # GET /web/v1/specification_names
  # GET /web/v1/specification_names.json
  def index
    @specification_names = SpecificationName.all

    render json: @specification_names
  end

  # GET /web/v1/specification_names/1
  # GET /web/v1/specification_names/1.json
  def show
    render json: @specification_name
  end

  # POST /web/v1/specification_names
  # POST /web/v1/specification_names.json
  def create
    @specification_name = SpecificationName.new(specification_name_params)

    if @specification_name.save
      render json: @specification_name, status: :created
    else
      render json: @specification_name.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/specification_names/1
  # PATCH/PUT /web/v1/specification_names/1.json
  def update
    @specification_name = SpecificationName.find(params[:id])

    if @specification_name.update(specification_name_params)
      head :no_content
    else
      render json: @specification_name.errors, status: :unprocessable_entity
    end
  end

   def delete_specification_names
     @specification_names = params[:specification_name_ids]
     @specification_names.each do |specification_name|
       SpecificationName.find(specification_name).delete
     end
  end

  def specifications_by_type
    @specification_names = SpecificationName.where(specification_type_id: params[:specification_type_id])

    render json: @specification_names
  end  

  # DELETE /web/v1/specification_names/1
  # DELETE /web/v1/specification_names/1.json
  def destroy
    @specification_name.destroy

    head :no_content
  end

  private

    def set_specification_name
      @specification_name = SpecificationName.find(params[:id])
    end

    def specification_name_params
      params.require(:specification_name).permit(:name, :specification_type_id)
    end
end
