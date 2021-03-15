class Website::FinanceDocumentsController < ApplicationController
  before_action :set_finance_document, only: [:show]
  skip_before_filter :authenticate_user!
  # GET /web/v1/finance_documents
  # GET /web/v1/finance_documents.json
  # def index
  #   @finance_documents = FinanceDocument.all

  #   render json: @finance_documents
  # end

  # GET /web/v1/finance_documents/1
  # GET /web/v1/finance_documents/1.json
  def show
    render json: @finance_document
  end

  def get_document
    render json: FinanceDocument.where('category = ? and family = ? ', params[:category], params[:family]).first
  end  

  def email_document
    UserMailer.delay.send_finance_document(params[:email], params[:family])
    render json: {message: "Document Sent!"}
  end  

  # POST /web/v1/finance_documents
  # POST /web/v1/finance_documents.json
  

  private

    def set_finance_document
      @finance_document = FinanceDocument.find(params[:id])
    end

end
