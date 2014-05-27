module TournamentHelper

	def flag_tag team
		image_tag("flags/#{team.code}.png", class: 'flag')
	end

end
