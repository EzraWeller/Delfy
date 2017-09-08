class BranchIdea < ApplicationRecord
	belongs_to :idea
	belongs_to :user
	belongs_to :community
	has_many   :votes
	default_scope -> { order(votes_count: :desc) }
	validates  :user_id, presence: true
	validates  :community_id, presence: true
	validates  :idea_id, presence: true
	validates  :content, presence: true, length: { maximum: 140 }
	paginates_per 25

	searchable do
	    text :content
	    integer :community_id
	end

	def page(order = "votes_count", direction = ">=", per_page = 25)
		direction == ">=" ? opp_dir = ">" : opp_dir = "<"
		if BranchIdea.where(order => self.send(order)).count > 1
			position = BranchIdea.where(order => self.send(order)).where("created_at <= ?", self.send(:created_at)).count + 
						BranchIdea.where("#{order} #{opp_dir} ?", self.send(order)).count
		else
			position = BranchIdea.where("#{order} #{direction} ?", self.send(order)).count
		end 
		(position.to_f/per_page).ceil
	end
end
