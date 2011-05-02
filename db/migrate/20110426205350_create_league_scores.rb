class CreateLeagueScores < ActiveRecord::Migration
  def self.up
    create_table :league_scores do |t|
      t.integer :league_id, :null => false
      t.integer :shooter_id, :null => false
      t.integer :score, :null => false
      t.date :shot_at
      t.timestamps
    end
  end

  def self.down
    drop_table :league_scores
  end
end
