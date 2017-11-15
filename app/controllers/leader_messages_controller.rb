class LeaderMessagesController < ApplicationController

	def create
		@leader_message = LeaderMessage.new(leader_message_params)
		if @leader_message.save
			flash[:success] = "New leader message posted."
		else
			flash[:danger] = "New message failed to be posted."
		end
		redirect_to community_admin_path(@leader_message.community)
	end

	def update

	end

	def destroy

	end

	private

		def leader_message_params
			params.require(:leader_message).permit(:content, :user_id, :community_id)
		end

end
