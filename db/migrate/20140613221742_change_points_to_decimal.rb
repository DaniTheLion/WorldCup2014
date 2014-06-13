class ChangePointsToDecimal < ActiveRecord::Migration
  def change
  	change_column :users, :points, :decimal
  end
end
