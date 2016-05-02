class RemoveUrlFromLinks < ActiveRecord::Migration
  def change
    remove_column :links, :url, :string
  end
end
