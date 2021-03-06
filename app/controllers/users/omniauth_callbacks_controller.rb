class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"].except("extra")
      flash[:alert] = "Facebook signup failed. Please make sure the account does not already exist and the username/email associated with your Facebook account is unique."
      redirect_to new_user_registration_url
    end
  end

  def google_oauth2
     @user = User.from_omniauth(request.env["omniauth.auth"])
 
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
    else
      session["devise.google_data"] = request.env["omniauth.auth"].except("extra")
      
      flash[:alert] = "Google signup failed. Please make sure the account does not already exist and the username/email associated with your Google account is unique."
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end