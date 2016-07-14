class UsersController < ApplicationController
  def profile
    @user = User.find_by_username(params[:username])
    redirect_to :root, alert: "User not fourd" if @user.nil?
    redirect_to edit_user_registration_path if @user == current_user
  end
end