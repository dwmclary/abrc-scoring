class CreateTournamentMembers < ActiveRecord::Migration
  def self.up
    create_table :tournament_members do |t|
      t.integer :tournament_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :tournament_members
  end
end
