module TournamentHelper

	def flag_tag team
		image_tag("flags/#{team.code}.png", class: 'flag')
	end

	def team_name_and_flag(team)	
		content_tag(:div, team.name) + flag_tag(team)
	end	
end
