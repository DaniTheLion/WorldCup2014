class Match < ActiveRecord::Base
	belongs_to :team_a, class_name: "Team", foreign_key: "team_a_id"
	belongs_to :team_b, class_name: "Team", foreign_key: "team_b_id"

	enum round: [:group_round, :quarter_final, :semi_final, :final]

end
