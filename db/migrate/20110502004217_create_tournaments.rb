class CreateTournaments < ActiveRecord::Migration
  def self.up
    create_table :tournaments do |t|
      t.string :name, :null => false
      t.integer :distance, :null => false
      t.date  :shot_at, :null => false
      t.timestamps
    end
    add_column :rounds, :tournament_id, :integer
  end

  def self.down
    drop_table :tournaments
    remove_column :rounds, :tournament_id
  end
end
