class TournamentController < ApplicationController
	before_filter :authenticate_user!

	def show
		@matches = Match.all
	end
end
