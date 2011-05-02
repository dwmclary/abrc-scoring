class AddAdminToShooter < ActiveRecord::Migration
  def self.up
    add_column :shooters, :is_admin, :boolean, :default => false
  end

  def self.down
    remove_column :shooters, :is_admin
  end
end
