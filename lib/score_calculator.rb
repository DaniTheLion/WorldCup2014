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
			a = relevant_bets.collect{ |bet| team_score_for_match(bet.team, match) }.compact.sum
		end

		def self.team_score_for_match(team, match)
			r1 = team.rank
			r2 = match.other_team(team).rank
			result = match.result_for(team)
			SCORES_BY_RANK_VS_RANK[r1][r2][result]
		end
end