class AddTypeMoneyToUser < ActiveRecord::Migration
  def change
    add_column :users, :auth_level, :integer
    add_column :users, :money, :integer
  end
end
