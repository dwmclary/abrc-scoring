class AddShooterPassword < ActiveRecord::Migration
  def self.up
    add_column :shooters, :hashed_password, :string
    add_column :shooters, :salt, :string
  end

  def self.down
    remove_column :shooters, :hashed_password
    remove_column :shooters, :salt
  end
end
