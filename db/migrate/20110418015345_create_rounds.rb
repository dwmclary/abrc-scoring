class CreateRounds < ActiveRecord::Migration
  def self.up
    create_table :rounds do |t|
      t.integer :shooter_id, :null => false
      t.integer :total_score
      t.integer :total_bullseye
      t.integer :end_count, :null => false, :default => 10
      t.integer :arrow_count, :null => false, :default => 3
      t.date :shot_at

      t.timestamps
    end
  end

  def self.down
    drop_table :rounds
  end
end
