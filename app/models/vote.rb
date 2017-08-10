class Vote < ApplicationRecord
	belongs_to :user
	belongs_to :community
	belongs_to :idea

	private

end