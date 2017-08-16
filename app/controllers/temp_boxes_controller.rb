class TempBoxesController < ApplicationController
	def create
		@temp_box = TempBox.new(temp_box_params)
	end

	def destroy
		@temp_box = TempBox.find_by(temp_box_params)
	end

	private

		def temp_box_params
			params.require(:temp_box) #.permit(:votes)
		end
end