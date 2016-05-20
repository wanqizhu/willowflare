class AddPayingIncentiveToUsers < ActiveRecord::Migration
  def change
    add_column :users, :paying_incentive, :integer
    add_column :users, :fav_game, :string
    add_column :users, :num_games, :integer
  end
end
