class AddTypeMoneyToUser < ActiveRecord::Migration
  def change
    add_column :users, :type, :string
    add_column :users, :money, :integer
  end
end
