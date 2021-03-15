class Web::V1::AuditController < ApplicationController

	def audit_logs
   #      all_details = bookings + master_data + vehicle_details + dealer_details
	 	# total = all_details.collect { |f| {type:f.auditable_type, user:User.find_by_id(f.user_id).try(:email), action:f.action, changes: f.audited_changes, action_time: f.created_at} }
	 	# @audit_logs = total.sort_by {|a| a[:action_time]}.reverse!
	 	# render json: @audit_logs, root: "audits"
	 	total = Audited.audit_class.all.collect { |f| { type: f.auditable_type, user: User.find_by_id(f.user_id).try(:email), action:f.action, changes: f.audited_changes, action_time: f.created_at} if f.user_id }.compact
	 	@audit_logs = total.sort_by {|a| a[:action_time]}.reverse!
	 	render json: @audit_logs, root: "audits"
	 end


	end
