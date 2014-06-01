class CreateBets < ActiveRecord::Migration
  def change
    create_table :bets do |t|
      t.integer :type
      t.integer :user_id

      t.timestamps
    end
  end
end
