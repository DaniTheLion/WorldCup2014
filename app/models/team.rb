class Team < ActiveRecord::Base
	attr_accessible :code, :name, :rank
	has_many :bets

	# has_many :matches_as_team_a, class_name: "Match", foreign_key: "team_a_id"
	# has_many :matches_as_team_b, class_name: "Match", foreign_key: "team_b_id"

	scope :first_rank, -> { where(rank: 1) }
	scope :second_rank, -> { where(rank: 2) }
	scope :third_rank, -> { where(rank: 3) }
	scope :forth_rank, -> { where(rank: 4) }

	def matches
		Match.where("team_a_id = ? OR team_b_id = ?", self.id, self.id)
	end
end
