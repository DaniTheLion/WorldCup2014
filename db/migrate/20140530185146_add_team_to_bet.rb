class AddTeamToBet < ActiveRecord::Migration
  def change
    add_column :bets, :team_id, :integer
  end
end
