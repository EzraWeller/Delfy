class Community < ApplicationRecord
	validates(:name,  presence: true, length: { maximum: 100 })
	validates(:description,  presence: true, length: { maximum: 400 })
	validates(:leader,  presence: true)
end