class AddImgToLinks < ActiveRecord::Migration
  def change
  	add_column :links, :img, :string
  end
end
