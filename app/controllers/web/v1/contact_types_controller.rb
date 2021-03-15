class Web::V1::ContactTypesController < ApplicationController
  before_action :set_contact_type, only: [:show, :update, :destroy]

  # GET /web/v1/contact_types
  # GET /web/v1/contact_types.json
  def index
    @contact_types = ContactType.all

    render json: @contact_types
  end

  # GET /web/v1/contact_types/1
  # GET /web/v1/contact_types/1.json
  def show
    render json: @contact_type
  end

  # POST /web/v1/contact_types
  # POST /web/v1/contact_types.json
  def create
    @contact_type = ContactType.new(contact_type_params)

    if @contact_type.save
      audit(@contact_type, current_user)
      render json: @contact_type, status: :created
    else
      render json: @contact_type.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/contact_types/1
  # PATCH/PUT /web/v1/contact_types/1.json
  def update
    @contact_type = ContactType.find(params[:id])

    if @contact_type.update(contact_type_params)
      audit(@contact_type, current_user)
      head :no_content
    else
      render json: @contact_type.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/contact_types/1
  # DELETE /web/v1/contact_types/1.json
  def destroy
    audit(@contact_type, current_user)
    @contact_type.destroy

    head :no_content
  end

  def delete_contact_types
    @contact_types = params[:contact_type_ids]
    @contact_types.each do |contact_type|
      ContactType.find(contact_type).delete
    end
  end

  private

    def set_contact_type
      @contact_type = ContactType.find(params[:id])
    end

    def contact_type_params
      params.require(:contact_type).permit(:label, :contact_type)
    end
end
