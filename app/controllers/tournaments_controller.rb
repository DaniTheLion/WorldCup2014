class TournamentsController < ApplicationController
	before_filter :authenticate_user!
	before_filter :validate_placed_bet, only: :show 

	def show
      @next_matches = Match.where("starting_time > ?", Time.now).all
      @teams = Team.all
      respond_to do |format|
      	format.html
      	format.js
	  end
	end

	def new_bet
	  @step = current_user.bets.count
	  @teams = team_options
	  @type_of_bet = Bet.type_for(@step)
	  respond_to do |format|
	  	format.html
	  	format.js
	  end
	end

  # ahm..
	def place_bet
	  current_user.bets.create(bet_params)

      respond_to do |format|
      	if current_user.placed_full_bet?
        # format.js{ redirect_to tournament_path }
     	    # redirect_to tournament_path 
          format.js { render :js => "window.location.href = '#{tournament_path}'" }
      	else 
      	  format.js{ redirect_to new_bet_tournament_path}
      	end
      end
	end


  private 

  	def team_options
      case @step
      when 0
      	Team.first_rank
      when 1
      	Team.second_rank
      when 2
      	Team.third_rank
      when 3
      	Team.forth_rank
      else
        Team.all
      end

  	end

  	def validate_placed_bet
  	  if current_user.placed_full_bet? 
  	  	return
  	  else
  	  	redirect_to new_bet_tournament_path 
  	  end
  	end

  	def bet_params
  	  params.require(:bet).permit(:team_id, :type_of_bet)
  	end
end
