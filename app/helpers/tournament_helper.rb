module TournamentHelper

	def flag_tag team
		image_tag("flags/#{team.code}.png", class: 'flag')
	end

	def team_name_and_flag(team)	
		content_tag(:div, team.name) + flag_tag(team)
	end	


	def future_match_regular_bet_prospect match
		relevant_bets = current_user.bets.select{ |b| match.teams.include? b.team }
		return if relevant_bets.empty?

		r = relevant_bets.select{ |b| ['team_a', 'team_b', 'team_c', 'team_d'].include? b.type_of_bet }.collect do |b|
			msg_for_future_match match, b
		end
		r.join("<br>")
	end


	def msg_for_future_match match, bet
		bet_team = match.team_a == bet.team ? match.team_a : match.team_b
		r1 = bet_team.rank
		r2 = match.other_team(bet_team).rank

		msg = []
		msg << "You'll win #{ScoreCalculator::SCORES_BY_RANK_VS_RANK[r1][r2][:win]} points if #{bet_team.name.capitalize} wins"

		points_to_be_earned = ScoreCalculator::SCORES_BY_RANK_VS_RANK[r1][r2][:draw]
		if points_to_be_earned != 0
			msg << "#{pluralize(points_to_be_earned, 'point')} if it's a draw"
		end		

		points_to_be_lost = -ScoreCalculator::SCORES_BY_RANK_VS_RANK[r1][r2][:lost]
		if points_to_be_lost != 0
			msg << "you'll lose #{pluralize(points_to_be_lost, 'point')} if #{bet_team.name.capitalize} loses"
		end

		last = msg.pop
		msg.join(', ') + " and #{last}."
	end

	def future_match_custom_bet_prospect match
		relevant_bets = current_user.bets.select{ |b| match.teams.include? b.team }
		return if relevant_bets.empty?

		msg = relevant_bets.collect do |b| 
			if b.type_of_bet == 'scores_the_most'
				"You'll win half a point for every goal #{b.team.name.capitalize} scores."
			elsif b.type_of_bet == 'gets_the_most'
				"You'll win half a point for every goal scored to #{b.team.name.capitalize}."
			end
		end
		msg.compact.join("<br>")
	end
end

