require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
  	@user = User.new(email: "test@test.com", password: "password")
  	@user2 = User.new(email: "test2@test.com", password: "password", referral: "test@test.com")
  	@user2 = User.new(email: "test2@test.com", password: "password", referral: "DO_NOT_EXIST")
  
  	@user.save
  	@user2.save
  end


  test "user basics" do
    assert @user.valid?
    assert @user2.valid?
    assert !@user3.valid?
    
    # use this to print to stdout (since we set config.logger = Logger.new(STDOUT) in test.rb)
    Rails.application.config.logger.error User.where(username: "1")[0]
    
    assert @user.money == 50
    assert @user2.money == 80, "check referral rewards work"
  end
end
