class Bet < ActiveRecord::Base
  attr_accessible :team_id, :type_of_bet

  belongs_to :user
  belongs_to :team
  enum type_of_bet: [:team_a, :team_b, :team_c, :team_d]
  validates_presence_of :team
  def self.type_for(step)
	self.type_of_bets.invert[step]
  end

end
