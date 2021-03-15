class Web::V1::WhatsappChatsController < ApplicationController
  before_action :set_whatsapp_chat, only: [:show, :update, :destroy]

  # GET /website/whatsapp_chats
  # GET /website/whatsapp_chats.json
  def index
    @whatsapp_chats = WhatsappChat.all

    render json: @whatsapp_chats
  end

  # GET /website/whatsapp_chats/1
  # GET /website/whatsapp_chats/1.json
  def show
    render json: @whatsapp_chat
  end

  # POST /website/whatsapp_chats
  # POST /website/whatsapp_chats.json
  def create
    @whatsapp_chat = WhatsappChat.new(whatsapp_chat_params)

    if @whatsapp_chat.save
      render json: @whatsapp_chat, status: :created
    else
      render json: @whatsapp_chat.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /website/whatsapp_chats/1
  # PATCH/PUT /website/whatsapp_chats/1.json
  def update
    @whatsapp_chat = WhatsappChat.find(params[:id])

    if @whatsapp_chat.update(whatsapp_chat_params)
      head :no_content
    else
      render json: @whatsapp_chat.errors, status: :unprocessable_entity
    end
  end

  # DELETE /website/whatsapp_chats/1
  # DELETE /website/whatsapp_chats/1.json
  def destroy
    @whatsapp_chat.destroy

    head :no_content
  end

  #for multiple delete
  def delete_multiple_chats
    @chats = params[:chat_ids]
    @chats.each do |cha|
      WhatsappChat.find(cha).delete
    end
  end

  private

    def set_whatsapp_chat
      @whatsapp_chat = WhatsappChat.find(params[:id])
    end

    def whatsapp_chat_params
      params.require(:whatsapp_chat).permit(:contact_number, :default_message, :label)
    end
end
