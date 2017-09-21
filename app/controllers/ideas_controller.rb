class IdeasController < ApplicationController
	before_action :community_member, only: [:create]
	
	def create
		@idea = current_user.ideas.build(idea_params)
		if @idea.save
			flash[:success] = "Idea created!"
			redirect_to root_url
		else
			flash[:danger] = "Idea creation failed."
			redirect_to root_url
		end
	end

	def show
		@idea = Idea.find(params[:id])
		@branch_idea = BranchIdea.new
	end

	def sort_branch_ideas
		@idea = Idea.find_by(id: params[:idea])
		sort_branch_ideas_by(@idea.id, branch_idea_sort_params)
	end

	def search
		# @searchterms = params[:search]
		# @search = Idea.search do
		#	fulltext params[:search], fields: :content
		#	with :community_id, params[:community_id]
		#	paginate per_page: 150
		# end
		# @searchbranches = Idea.search do
		#	fulltext params[:search]
		#	with :community_id, params[:community_id]
		#	paginate per_page: 150
		# end
		# @justbranches = BranchIdea.search do
		#	fulltext params[:search]
		#	with :community_id, params[:community_id]
		#	paginate per_page: 150
		# end
		# @ideas = @search.results
		# @ideas_w_branches = @searchbranches.results - @ideas
		# @branches = @justbranches.results
		@ideas = Idea.search_content_for(params[:search]).where(community_id: params[:community_id])
			@searchedbranches = BranchIdea.search_content_for('lorem').where(community_id: params[:community_id]).pluck(:id)
			@branchesideas = Idea.where(id: BranchIdea.where(id: @searchedbranches).pluck(:idea_id)).distinct
		@ideas_w_branches = @branchesideas - @ideas
		@branches = BranchIdea.search_content_for(params[:search])
	end

	private

		def idea_params
     		params.require(:idea).permit(:content, :user_id, :community_id)
    	end

    	def branch_idea_sort_params
    		params.require(:branch_sort_style)
    	end

end