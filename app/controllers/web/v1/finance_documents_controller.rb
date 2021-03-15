class Web::V1::FinanceDocumentsController < ApplicationController
  before_action :set_finance_document, only: [:show, :update, :destroy]

  # GET /web/v1/finance_documents
  # GET /web/v1/finance_documents.json
  def index
    @finance_documents = FinanceDocument.all.order("updated_at DESC").order("created_at DESC")

    render json: @finance_documents
  end

  # GET /web/v1/finance_documents/1
  # GET /web/v1/finance_documents/1.json
  def show
    render json: @finance_document
  end

  # POST /web/v1/finance_documents
  # POST /web/v1/finance_documents.json
  def create
    @finance_document = FinanceDocument.new(finance_document_params)

    if @finance_document.save
      audit(@finance_document, current_user)
      render json: @finance_document, status: :created
    else
      render json: @finance_document.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/finance_documents/1
  # PATCH/PUT /web/v1/finance_documents/1.json
  def update
    @finance_document = FinanceDocument.find(params[:id])

    if @finance_document.update(finance_document_params)
      audit(@finance_document, current_user)
      head :no_content
    else
      render json: @finance_document.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/finance_documents/1
  # DELETE /web/v1/finance_documents/1.json
  def destroy
    audit(@finance_document, current_user)
    @finance_document.destroy

    head :no_content
  end

  def delete_finance_documents
    @finance_documents = params[:finance_document_ids]
    @finance_documents.each do |finance_document|
    FinanceDocument.find(finance_document).delete
    end
  end

  private

  def set_finance_document
    @finance_document = FinanceDocument.find(params[:id])
  end

  def finance_document_params
    params.require(:finance_document).permit(:category, :document_list, :family)
  end
end
