class CreateShooters < ActiveRecord::Migration
  def self.up
    create_table :shooters do |t|
      t.string :name, :null => false
      t.integer :best_score, :default => 0
      t.decimal :average_score

      t.timestamps
    end
  end

  def self.down
    drop_table :shooters
  end
end
