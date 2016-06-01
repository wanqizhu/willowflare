class ChangeReferralToString < ActiveRecord::Migration
  def change
  	change_column :users, :referral, :string
  end
end
