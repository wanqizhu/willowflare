class AddReferralToUsers < ActiveRecord::Migration
  def change
    add_column :users, :referral, :integer
  end
end
