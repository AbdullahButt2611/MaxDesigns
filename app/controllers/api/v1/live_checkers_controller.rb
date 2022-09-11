class Api::V1::LiveCheckersController < ApplicationController
	def identify
		render :json => {"status": "Up and Running"}, status: :ok
	end
end