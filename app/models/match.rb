class Match < ActiveRecord::Base
	require './lib/score_calculator.rb'

	belongs_to :team_a, class_name: "Team", foreign_key: "team_a_id"
	belongs_to :team_b, class_name: "Team", foreign_key: "team_b_id"

	enum round: [:group_round, :eighth_final, :quarter_final, :semi_final, :final]

	attr_accessible :round, :starting_time, :team_a, :team_b

	store_accessor :score, :team_a_score, :team_b_score, :shoot_out

	scope :completed, -> { where("score is not null") }

	after_save { |m| ScoreCalculator.re_calculate_user_scores }

	def teams
		[team_a, team_b]
	end

	def other_team(team)
		team == team_a ? team_b : team_a
	end

	def result_for(team)
		if shoot_out 
			result_for_shoot_out(team)
		elsif draw?
			:draw
		elsif team == winner
			:win
		elsif team == loser
			:lost
		end
	end


	def result_for_shoot_out(team)
		a_score = shoot_out[:team_a_shoot_out_score].to_i
		b_score = shoot_out[:team_b_shoot_out_score].to_i
		winner = a_score > b_score ? team_a : team_b
		team == winner ? :win : :lost
	end

	def winner
		a_score = team_a_score.to_i
		b_score = team_b_score.to_i

		if a_score > b_score
			return team_a
		elsif a_score < b_score
			return team_b
		end
	end

	def loser
		unless winner.nil?
			other_team(winner)
		end 
	end

	def draw?
		team_a_score.to_i == team_b_score.to_i
	end

	def score_of team
		if team == team_a 
			team_a_score.to_i
		elsif team == team_b
			team_b_score.to_i
		end
	end

	def future_match?
		score.nil?
	end
end
