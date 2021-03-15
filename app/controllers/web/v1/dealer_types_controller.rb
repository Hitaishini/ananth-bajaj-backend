class Web::V1::DealerTypesController < ApplicationController
  before_action :se_dealer_type, only: [:show, :update, :destroy]

  # GET /web/v1/dealer_types
  # GET /web/v1/dealer_types.json
  def index
   @dealer_types = DealerType.all.order("updated_at DESC").order("created_at DESC")

   render json:@dealer_types
 end

  # GET /web/v1/dealer_types/1
  # GET /web/v1/dealer_types/1.json
  def show
    render json:@dealer_type
  end

  # POST /web/v1/dealer_types
  # POST /web/v1/dealer_types.json
  def create
   @dealer_type = DealerType.new(dealer_type_params)

   if@dealer_type.save
     audit(@dealer_type, current_user)
    render json:@dealer_type, status: :created
  else
    render json:@dealer_type.errors, status: :unprocessable_entity
  end
end

  # PATCH/PUT /web/v1/dealer_types/1
  # PATCH/PUT /web/v1/dealer_types/1.json
  def update
   @dealer_type = DealerType.find(params[:id])

   if@dealer_type.update(dealer_type_params)
     audit(@dealer_type, current_user)
    head :no_content
  else
    render json:@dealer_type.errors, status: :unprocessable_entity
  end
end

  # DELETE /web/v1/dealer_types/1
  # DELETE /web/v1/dealer_types/1.json
  def destroy
   audit(@dealer_type, current_user)
   @dealer_type.destroy

   head :no_content
 end

 def delete_dealer_types
  @dealer_types = params[:dealer_type_ids]
   @dealer_types.each do |dealer_type|
    DealerType.find(dealer_type).delete
  end
end

private

def se_dealer_type
 @dealer_type = DealerType.find(params[:id])
end

def dealer_type_params
  params.require(:dealer_type).permit(:dealer_type)
end
end
