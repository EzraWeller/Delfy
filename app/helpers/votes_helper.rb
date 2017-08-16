module VotesHelper

	private

		# New root idea when adding a vote
		def new_root_when_creating
			if @vote.root
			elsif Vote.where(branch_idea: @vote.branch_idea).count > @vote.idea.votes.where(root: true).count
				# Store branch idea info
				@temp_content    = @vote.branch_idea.content
				@temp_created_at = @vote.branch_idea.created_at
				@temp_branch     = @vote.branch_idea
				@temp_user       = @vote.branch_idea.user
				# Set aside the root idea's votes.
				# @vote.idea.votes.where(root: true).each do |i|
				#	i.update(root: nil, branch_idea_id: '-1')
				# end
				@temp_box = TempBox.new(votes: @vote.idea.votes.where(root: true))
				# Put the previous root idea info into the branch idea
				@vote.branch_idea.update(content: @vote.idea.content, 
										 created_at: @vote.idea.created_at, 
										 user: @vote.idea.user)
				@vote.branch_idea.votes.each do |b|
					b.update(root: true, branch_idea: nil)
				end
				# Put the previous branch idea info into the root idea
				@vote.idea.update(content: @temp_content, created_at: @temp_created_at, 
								  user: @temp_user)
				# Vote.where(branch_idea_id: '-1').each do |i|
				#	i.update(branch_idea: @temp_branch)
				# end
				@temp_box.votes.each do |v|
					v.update(branch_idea: @temp_branch, root: nil)
				end
				@temp_box.destroy
			else
			end
		end

		# New root idea when destroying a vote
		def new_root_when_destroying
			# If deleting a vote from a branch idea, do nothing
			if @vote.branch_idea
			else
				# Save a branch idea if it now has more votes than the root.
				@vote.idea.branches.each do |b|
					Vote.where(branch_idea: b).count > @vote.idea.votes.where(root: true).count ? @new_root = b : nil
				end
				# If a branch got saved, swap its info with the root to make a new root idea.
				if @new_root
					# Store branch idea info
					@temp_content    = @new_root.content
					@temp_created_at = @new_root.created_at
					@temp_branch     = @new_root
					@temp_user       = @new_root.user
					# Set aside the root idea's votes.
					# @vote.idea.votes.where(root: true).each do |i|
					#	i.update(root: nil, branch_idea_id: '-1')
					# end
					@temp_box = TempBox.new(votes: @vote.idea.votes.where(root: true))
					# Put the previous root idea info into the branch idea
					@new_root.update(content: @vote.idea.content, 
									 created_at: @vote.idea.created_at, 
									 user: @vote.idea.user)
					@new_root.votes.each do |b|
						b.update(root: true, branch_idea: nil)
					end
					# Put the previous branch idea info into the root idea
					@vote.idea.update(content: @temp_content, created_at: @temp_created_at, 
								  	  user: @temp_user)
					# Vote.where(branch_idea_id: '-1').each do |i|
					#	i.update(branch_idea: @temp_branch)
					# end
					@temp_box.votes.each do |v|
						v.update(branch_idea: @temp_branch, root: nil)
					end
					@temp_box.destroy
				else
				end
			end
		end
end
