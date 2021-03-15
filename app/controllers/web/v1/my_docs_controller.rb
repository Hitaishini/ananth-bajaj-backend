class Web::V1::MyDocsController < ApplicationController
  before_action :set_my_doc, only: [:show, :update, :destroy]

  # GET /web/v1/my_docs
  # GET /web/v1/my_docs.json
  def index
    @my_docs = MyDoc.all.order("updated_at DESC").order("created_at DESC")

    render json: @my_docs
  end

  # GET /web/v1/my_docs/1
  # GET /web/v1/my_docs/1.json
  def show
    render json: @my_doc
  end

  # POST /web/v1/my_docs
  # POST /web/v1/my_docs.json
  def create
    @my_doc = MyDoc.new(my_doc_params)

    if @my_doc.save
      render json: @my_doc, status: :created
    else
      render json: @my_doc.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/my_docs/1
  # PATCH/PUT /web/v1/my_docs/1.json
  def update
    @my_doc = MyDoc.find(params[:id])

    if @my_doc.update(my_doc_params)
      head :no_content
    else
      render json: @my_doc.errors, status: :unprocessable_entity
    end
  end

  def my_docs_image_update
     @my_doc = MyDoc.find(params[:id])
     @my_doc.remove_image! if @my_doc.image

    if @my_doc.update(my_doc_params)
       @my_doc.image = params[:my_doc][:image]
       @my_doc.save
      render json: @my_doc
    else
      render json: @my_doc.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/my_docs/1
  # DELETE /web/v1/my_docs/1.json
  def destroy
    @my_doc.destroy

    head :no_content
  end

  def delete_my_docs
    @my_docs = params[:my_doc_ids]
    @my_docs.each do |my_doc|
      MyDoc.find(my_doc).delete
    end
  end

  private

    def set_my_doc
      @my_doc = MyDoc.find(params[:id])
    end

    def my_doc_params
      params.require(:my_doc).permit(:image, :document_name, :user_id, :file_type)
    end
end
