class ChangeUserAttributesFromStringToInt < ActiveRecord::Migration
  def self.up
  	change_column :users, :nation, :integer
  	change_column :users, :device, :integer
    change_column :users, :OS, :integer
    change_column :users, :gender, :integer
  end

  def self.down
  	change_column :users, :nation, :string
  	change_column :users, :device, :string
    change_column :users, :OS, :string
    change_column :users, :gender, :string
  end
end
