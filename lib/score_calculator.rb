module ScoreCalculator
		SCORE_PER_GOAL = 0.5

		SCORES_BY_RANK_VS_RANK = { 
			1 => {
				1 => { win: 3, draw: 1, lost: 0 },
				2 => { win: 3, draw: 1, lost: 0	},
				3 => { win: 3, draw: 1, lost: -1 },
				4 => { win: 3, draw: 0, lost: -2 }
				},

			2 => {
				1 => { win: 3, draw: 1, lost: 0 },
				2 => { win: 3, draw: 1, lost: 0 },
				3 => { win: 3, draw: 1, lost: 0 },
				4 => { win: 3, draw: 1, lost: -1 }
				},

			3 => {
				1 => { win: 5, draw: 2, lost: 0 },
				2 => { win: 3, draw: 1, lost: 0 },
				3 => { win: 3, draw: 1, lost: 0 },
				4 => { win: 3, draw: 1, lost: 0	}
				},
			4 => {
				1 => { win: 6, draw: 3, lost: 0 },
				2 => { win: 5, draw: 2, lost: 0 },
				3 => { win: 3, draw: 1, lost: 0 },
				4 => { win: 3, draw: 1, lost: 0 }
				}
			}

			SCORE_FOR_KO_QUALIFICATION_BY_RANK = {
				1 => 2,
				2 => 3,
				3 => 5,
				4 => 7
			}

			SCORE_FOR_WINNING_BY_RANK = {
				1 => 5,
				2 => 7,
				3 => 10,
				4 => 15
			}


	def self.re_calculate_user_scores
		ActiveRecord::Base.transaction do
			User.includes(:bets).all.each{ |u| u.points = score_for_user(u); u.save}
		end
	end


	def self.score_for_user(user)
		completed_matches = Match.includes(:team_a, :team_b).completed
		completed_matches.collect{ |m| user_score_for_match(user, m) }.sum
	end


	private
		def self.user_score_for_match(user, match)
			relevant_bets = user.bets.includes(:team).select{ |b| match.teams.include?(b.team) }
			relevant_bets.collect{ |bet| bet_score_for_match(bet, match) }.compact.sum
		end

		def self.bet_score_for_match(bet, match)
			bet_type = bet.type_of_bet.to_sym
			score = 0
			if [:team_a, :team_b, :team_c, :team_d].include? bet_type 
				r1 = bet.team.rank
				r2 = match.other_team(bet.team).rank
				result = match.result_for(bet.team)
				score += SCORES_BY_RANK_VS_RANK[r1][r2][result]
			elsif bet_type == :scores_the_most
				score += match.score_of(bet.team) * SCORE_PER_GOAL
			elsif bet_type == :gets_the_most
				score += match.score_of(match.other_team(bet.team)) * SCORE_PER_GOAL
			end	
			score + score_for_knockout_match(bet, match)			
		end

		def self.score_for_knockout_match(bet, match)
			bet_type = bet.type_of_bet.to_sym
			return 0 unless [:team_a, :team_b, :team_c, :team_d].include? bet_type

			result = match.result_for(bet.team)
			return 0 unless result == :win

			if ['eighth_final', 'quarter_final', 'semi_final'].include? match.round
				SCORE_FOR_KO_QUALIFICATION_BY_RANK[bet.team.rank]
			elsif match.round == 'final'
				SCORE_FOR_WINNING_BY_RANK[bet.team.rank]
			else
				0
			end
		end 
end