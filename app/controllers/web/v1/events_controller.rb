class Web::V1::EventsController < ApplicationController
  before_action :set_event, only: [:show, :update, :destroy]

  # GET /web/v1/events
  # GET /web/v1/events.json
  def index
    @events = Event.all.order("updated_at DESC").order("created_at DESC")

    render json: @events
  end

  # GET /web/v1/events/1
  # GET /web/v1/events/1.json
  def show
    render json: @event
  end

  # POST /web/v1/events
  # POST /web/v1/events.json
  def create
    @event = Event.new(event_params)
    users = User.all
    if @event.save
      @event.delay.call_notification(I18n.t('Notification.event_created'), I18n.t('Email.event_created'))
      render json: @event, status: :created
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/events/1
  # PATCH/PUT /web/v1/events/1.json
  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      @event.delay.call_notification(I18n.t('Notification.event_updated'), I18n.t('Email.event_updated'))
      head :no_content
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/events/1
  # DELETE /web/v1/events/1.json
  def destroy
    @event.delay.call_notification(I18n.t('Notification.event_deleted'), I18n.t('Email.event_deleted'))
    @event.destroy
    head :no_content
  end

  def delete_events
    @events = params[:event_ids]
    @events.each do |event|
      Event.find(event).destroy
    end
  end
  #user with event information
  def user_event_inforamtion
     @user_events = UserEvent.where(event_id: params[:event_id])

     render json: @user_events, root: "user_event_information", each_serializer: Web::V1::UserEventInformationSerializer
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:event_date, :event_time, :location, :title, :description, :coordinator_name, :coordinator_mobile)
  end
end
