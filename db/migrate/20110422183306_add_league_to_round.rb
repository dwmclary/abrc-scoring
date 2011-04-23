class AddLeagueToRound < ActiveRecord::Migration
  def self.up
    add_column :rounds, :league_id, :int
  end

  def self.down
    remove_column :rounds, :league_id
  end
end
