class RenameBetTypes < ActiveRecord::Migration
  def change
    rename_column :bets, :type, :type_of_bet
  end
end
