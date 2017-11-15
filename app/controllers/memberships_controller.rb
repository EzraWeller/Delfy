class MembershipsController < ApplicationController
	before_action :logged_in_user
	before_action :leader, only: [:remove]

	def create
		@community = Community.find(params[:community_id])
		if @community.membership_setting == "open"
			current_user.join(@community)
			redirect_to @community
		else
			@invitations = Invitation.where(community: @community)
			@invitations.each do |a|
				if a.authenticated?(params[:membership][:access_token])
					current_user.join(@community)
					a.update_attribute(:accepted, true)
				else
				end
			end
			if current_user.communities.include?(@community)
				flash[:success] = "Successfuly joined community!"
			else
				flash[:danger] = "Incorrect access code or invitation already accepted. Request a new invitation to the community."
			end
			redirect_to @community
		end
	end

	def destroy
		@community = Membership.find(params[:id]).community
		current_user.leave(@community)
		current_user.votes.where(community: @community).destroy_all
		redirect_to @community
	end

	def remove
		@community = Community.find_by(id: remove_params[:community_id])
		@user = User.find_by(id: remove_params[:user_id])
		@membership = Membership.find(params[:id])
		@reason = remove_params[:removal_reason]

		@membership.removal_reason = @reason
		if @membership.save
			@user.leave(@community)
			@user.votes.where(community: @community).destroy_all
			@user.send_removal(@membership)
			flash[:success] = "User membership removed and email sent."
		else
			flash[:danger] = "Failed to remove membership."
		end
		redirect_to community_admin_path(@community)
	end

	private

		def leader
			@community = Membership.find(params[:id]).community
			if @community.leader?(current_user)
			else
				redirect_to community_path(@community)
				flash[:danger] = "Only community leaders can access leader functions."
			end
		end

		def remove_params
			params.require(:membership).permit(:removal_reason, :community_id, :user_id)
		end

end
