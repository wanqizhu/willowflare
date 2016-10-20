class UsersController < ApplicationController

  # makes it so we don't return to sign-in page after signing in
  skip_before_filter :store_current_location 

  def profile
    @user = User.find_by_username(params[:username])
    if @user.nil?
      redirect_to :root, alert: "User not fourd"
      return
    end
    redirect_to edit_user_registration_path if @user == current_user
  end



  def login_page
    if user_signed_in?
      redirect_to :root, alert: "Already signed in"
    end
  end



end