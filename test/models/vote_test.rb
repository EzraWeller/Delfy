require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
  	@user = users(:ezra)
  	@community = communities(:USA)
  	@idea = ideas(:one)
  	@branch = branch_ideas(:one)
  end

  test "votes count updated when saving or destroying a root idea vote" do
  	@vote_for_root = Vote.new(idea: @idea, community: @community, user: @user)
  	assert_difference '@idea.votes.count', 1 do
    	@vote_for_root.save		
  	end
  	assert_difference '@idea.votes.count', -1 do
  		@vote_for_root.destroy
  	end
  end


end
