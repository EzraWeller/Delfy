class MembershipsController < ApplicationController
	before_action :logged_in_user

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

end
