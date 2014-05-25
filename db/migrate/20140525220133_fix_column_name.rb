class FixColumnName < ActiveRecord::Migration
  def up
    rename_column :matches, :team_a, :team_a_id
    rename_column :matches, :team_b, :team_b_id
  end

  def down
    # rename back if you need or do something else or do nothing
  end
end
