class AddTypeMoneyToUser < ActiveRecord::Migration
  def change
    add_column :users, :type, :string
    add_column :users, :money, :integer, :default => 10
  end
end
