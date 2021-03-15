class Website::EventsController < ApplicationController
  def show
    render json: Event.find(params[:id])
  end

	def user_responce_with_event
		@user_ride = UserEvent.find(params[:id])
		if params[:status] == "Yes"
			@user_ride.update(perticipate_event: "Yes")
		elsif params[:status] == "No"
			@user_ride.update(perticipate_event: "No")
		elsif params[:status] == "Maybe"
			@user_ride.update(perticipate_event: "Maybe")
		else
			@user_ride
		end
		render json: @user_ride
	end

	def user_events_information
		@user = User.find(params[:user_id])

		@user_accept = @user.user_events.where(perticipate_event:"Yes").collect { |user_event| Event.find(user_event.event_id) }
		@user_not_intrested = @user.user_events.where(perticipate_event:"No").collect { |user_event| Event.find(user_event.event_id) }
		@user_with_may_be = @user.user_events.where(perticipate_event:"Maybe").collect { |user_event| Event.find(user_event.event_id) }
		@not_replied = @user.user_events.where(perticipate_event:"Not Replied").collect { |user_event| Event.find(user_event.event_id) }

		@user_event_response = {participated: @user_accept, not_participated: @user_not_intrested, may_be: @user_with_may_be, not_replay: @not_replied}

		render json: @user_event_response
	end

	def event_with_user_information
		@event = Event.find(params[:ride_id])

		@event_accept_users = @event.user_events.where(perticipate_event:"Yes").collect { |event_user| User.find(event_user.user_id) } 
		@event_not_accept_users = @event.user_events.where(perticipate_event:"No").collect { |event_user| User.find(event_user.user_id) }
		@event_may_be_users = @event.user_events.where(perticipate_event:"Maybe").collect { |event_user| User.find(event_user.user_id) }
		@event_not_replied_users = @event.user_events.where(perticipate_event:"Not Replied").collect { |event_user| User.find(event_user.user_id) }     

		@event_with_user_responce = {participated_users: @event_accept_users, not_participated_users:  @event_not_accept_users, may_be_users: @event_may_be_users, not_replayed_users: @event_not_replied_users}

		render json: @event_with_user_responce
	end
end