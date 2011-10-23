class CreateTournamentScores < ActiveRecord::Migration
  def self.up
    create_table :tournament_scores do |t|
      t.integer :tournament_id, :null => false
      t.integer :user_id, :null => false
      t.integer :score, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :tournament_scores
  end
end
