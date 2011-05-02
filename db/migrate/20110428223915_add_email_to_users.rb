class AddEmailToUsers < ActiveRecord::Migration
  def self.up
    add_column :shooters, :email, :string
  end

  def self.down
    remove_column :shooters, :email
  end
end
