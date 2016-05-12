class AddPlayerProfileToUser < ActiveRecord::Migration
  def change
    add_column :users, :gender, :string
    add_column :users, :age, :integer
    add_column :users, :device, :string
    add_column :users, :OS, :string
    add_column :users, :time_spent, :integer
    add_column :users, :spending, :integer
    add_column :users, :motivation, :integer   # index of various types of primary motivation from a list
    add_column :users, :game_genre, :integer
    add_column :users, :nation, :string
    add_column :users, :info, :text
  end
end
