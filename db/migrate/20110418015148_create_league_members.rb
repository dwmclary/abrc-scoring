class CreateLeagueMembers < ActiveRecord::Migration
  def self.up
    create_table :league_members do |t|
      t.integer :league_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :league_members
  end
end
