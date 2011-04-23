class CreateLeagues < ActiveRecord::Migration
  def self.up
    create_table :leagues do |t|
      t.string :name, :null => false
      t.integer :distance

      t.timestamps
    end
  end

  def self.down
    drop_table :leagues
  end
end
