class AddImagesToThreddedPosts < ActiveRecord::Migration
  def change
    add_column :thredded_posts, :images, :text
  end
end
