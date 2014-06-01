class Team < ActiveRecord::Base
	attr_accessible :code, :name
	has_many :bets

	scope :first_rank, -> { where(:name => ['Brazil', 'Spain', 'Germany', 'Argentina', 'Netherlands', 'Italy', 'England','Portugal']) }
	scope :second_rank, -> { where(:name => ['France', 'Croatia', 'Russia', 'Colombia', 'Belgium', 'Uruguay', 'Switzerland','Mexico']) }
	scope :third_rank, -> { where(:name => ['Greece', 'Chile', 'Ecuador', 'Côte d\'Ivoire', 'Nigeria', 'Cameroon', 'Boasnia and Herzegovina','USA']) }
	scope :forth_rank, -> { where(:name => ['Japan', 'Iran', 'Australia', 'Korea Republic', 'Costa Rica', 'Honhuras', 'Algeria','Ghana']) }


end
