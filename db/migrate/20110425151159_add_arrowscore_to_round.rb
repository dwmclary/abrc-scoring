class AddArrowscoreToRound < ActiveRecord::Migration
  def self.up
    add_column :rounds, :arrow_score, :int, :default => 10
  end

  def self.down
    remove_column :rounds, :arrow_score
  end
end
