class CreateRoundEnds < ActiveRecord::Migration
  def self.up
    create_table :round_ends do |t|
      t.integer :user_id, :null => false
      t.integer :round_id, :null => false
      t.integer :end_count, :null => false
      t.integer :arrow_count, :null => false, :default => 3
      t.integer :x_count, :null => false, :default => 0
      t.integer :end_score, :null => false, :default => 0
      t.string :scores

      t.timestamps
    end
  end

  def self.down
    drop_table :round_ends
  end
end
