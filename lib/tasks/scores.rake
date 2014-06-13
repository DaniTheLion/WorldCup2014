namespace :scores do
	task :update_last_match, [:team_a_score, :team_b_score] => :environment do |t, args| 
		m = Match.where('score is null').order('starting_time asc').first
		m.score = {team_a_score: args[:team_a_score].to_i, team_b_score: args[:team_b_score].to_i}
		m.save
	end
end