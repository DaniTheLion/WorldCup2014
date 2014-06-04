class Team < ActiveRecord::Base
	attr_accessible :code, :name, :rank
	has_many :bets

	# has_many :matches_as_team_a, class_name: "Match", foreign_key: "team_a_id"
	# has_many :matches_as_team_b, class_name: "Match", foreign_key: "team_b_id"

	scope :first_rank, -> { where(:name => ['Brazil', 'Spain', 'Germany', 'Argentina', 'Netherlands', 'Italy', 'England','Portugal']) }
	scope :second_rank, -> { where(:name => ['France', 'Croatia', 'Russia', 'Colombia', 'Belgium', 'Uruguay', 'Switzerland','Mexico']) }
	scope :third_rank, -> { where(:name => ['Greece', 'Chile', 'Ecuador', 'Côte d\'Ivoire', 'Nigeria', 'Cameroon', 'Boasnia and Herzegovina','USA']) }
	scope :forth_rank, -> { where(:name => ['Japan', 'Iran', 'Australia', 'Korea Republic', 'Costa Rica', 'Honhuras', 'Algeria','Ghana']) }

	def matches
		Match.where("team_a_id = ? OR team_b_id = ?", self.id, self.id)
	end
end
