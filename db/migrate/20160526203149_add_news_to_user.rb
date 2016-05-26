class AddNewsToUser < ActiveRecord::Migration
  def change
    add_column :users, :news, :string
  end
end
