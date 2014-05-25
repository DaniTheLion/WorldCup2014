class TournamentController < ApplicationController
	before_filter :authenticate_user!
end
