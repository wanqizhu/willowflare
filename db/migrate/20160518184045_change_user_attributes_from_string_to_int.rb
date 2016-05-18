class ChangeUserAttributesFromStringToInt < ActiveRecord::Migration
  def change
  	remove_column :users, :nation, :string
  	remove_column :users, :device, :string
    remove_column :users, :OS, :string
    remove_column :users, :gender, :string
  	add_column :users, :nation, :integer
  	add_column :users, :device, :integer
    add_column :users, :OS, :integer
    add_column :users, :gender, :integer
  end
end
