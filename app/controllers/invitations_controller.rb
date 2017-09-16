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
		@emails = params[:invitations][:emails].tr(' ', '').split(",").uniq
		@community = Community.find_by(id: params[:invitations][:community_id])
		invite_successes = []
		invite_fails = []
		@emails.each do |e|
			@invitation = Invitation.new(email: e, community: @community, user: current_user)
			if @invitation.save
				current_user.invite(@invitation)
				invite_successes << e
			else
				invite_fails << e
			end
		end
		flash[:success] = "Invitations sent to: #{invite_successes}"
		flash[:danger] = "Invitations sent to: #{invite_fails}"
		redirect_to community_admin_path(@community)
	end

	private

	def invite_params
		params.require(:invitation).permit(:email, :community_id, :user_id)
	end

end
