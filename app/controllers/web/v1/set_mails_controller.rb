class Web::V1::SetMailsController < ApplicationController
  before_action :set_set_mail, only: [:show, :update, :destroy]

  # GET /web/v1/set_mails
  # GET /web/v1/set_mails.json
  def index
    @set_mails = SetMail.all

    render json: @set_mails
  end

  # GET /web/v1/set_mails/1
  # GET /web/v1/set_mails/1.json
  def show
    render json: @set_mail
  end

  # POST /web/v1/set_mails
  # POST /web/v1/set_mails.json
  def create
    @set_mail = SetMail.new(set_mail_params)

    if @set_mail.save
       audit(@set_mail, current_user)
      render json: @set_mail, status: :created
    else
      render json: @set_mail.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/set_mails/1
  # PATCH/PUT /web/v1/set_mails/1.json
  def update
    @set_mail = SetMail.find(params[:id])

    if @set_mail.update(set_mail_params)
       audit(@set_mail, current_user)
      head :no_content
    else
      render json: @set_mail.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/set_mails/1
  # DELETE /web/v1/set_mails/1.json
  def destroy
    audit(@set_mail, current_user)
    @set_mail.destroy

    head :no_content
  end

  def delete_set_mails
   @set_mails = params[:set_mail_ids]
   @set_mails.each do |set_mail|
    SetMail.find(set_mail).delete
  end
end

private

def set_set_mail
  @set_mail = SetMail.find(params[:id])
end

def set_mail_params
  params.require(:set_mail).permit(:email, :category, :location)
end
end
