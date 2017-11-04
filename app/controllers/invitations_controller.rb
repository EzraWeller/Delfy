class InvitationsController < ApplicationController

	def create
		@invitation = Invitation.new(invite_params)
		@invitation.save
		current_user.invite(@invitation)
		redirect_to community_admin_path(current_community)
		respond_to do |format|
			format.html { redirect_to community_admin_path(current_community) }
			format.js
		end
	end

	def create_many
		@all_emails = params[:invitations][:emails].tr(' ', '').tr("\r\n", '').split(",").uniq
		@community = Community.find_by(id: params[:invitations][:community_id])
		invite_successes = []
		invite_fails = []
		@emails = @all_emails.take(200)
			session[:emails_to_invite] = @emails
		@overflow_emails = @all_emails - @emails
			session[:overflow_emails] = @overflow_emails
		# @overflow_emails.each { |o| invite_fails << o }
		# @emails.each do |e|
		#	@invitation = Invitation.new(email: e, community: @community, user: current_user)
		# 	if @invitation.save
		# 		current_user.invite(@invitation)
		# 		invite_successes << e
		# 	else
		# 		invite_fails << e
		# 	end
		# end
		# flash[:success] = "Invitations sent: #{invite_successes.count}"
		# flash[:danger] = "Failed invitations: #{invite_fails.count}"
		# redirect_to community_admin_path(@community)
		redirect_to invite_confirm_path(@community)
	end

	def invite_confirm
		@community = Community.find_by(id: params[:id])
		@invitation = Invitation.new
	end

	def send_many
		@community = Community.find_by(id: params[:id])
		@emails = session[:emails_to_invite]
		@overflow_emails = session[:overflow_emails]
		invite_successes = []
		invite_fails = []
		@overflow_emails.each { |o| invite_fails << o }
		@emails.each do |e|
			@invitation = Invitation.new(email: e, community: @community, user: current_user)
			if @invitation.save
				current_user.invite(@invitation)
				invite_successes << e
			else
				invite_fails << e
			end
		end
		flash[:success] = "Invitations sent: #{invite_successes.count}"
		flash[:danger] = "Failed invitations: #{invite_fails.count}"
		session[:emails_to_invite] = []
		session[:overflow_emails] = []
		redirect_to community_admin_path(@community)
	end

	private

	def invite_params
		params.require(:invitation).permit(:email, :community_id, :user_id)
	end

end
