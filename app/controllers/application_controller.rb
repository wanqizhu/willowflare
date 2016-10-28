class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # saves username
  # see STRONG validation in Device documentation
  before_filter :configure_permitted_parameters, if: :devise_controller?


  # saves the location before loading each page so we can return to the
  # right page. If we're on a devise page, we don't want to store that as the
  # place to return to (for example, we don't want to return to the sign in page
  # after signing in), which is what the :unless prevents
  before_filter :store_current_location, :unless => :devise_controller?

  use Rack::GeoIPCountry, :db => File.expand_path(Rails.root.join("db/GeoIP.dat"))
  before_filter :redirect_if_china, :except => [:companies, :landing_page]


  # helpers to enable sign-up form on the landing page
  helper_method :resource_name, :resource, :devise_mapping

  def resource_name
    :user
  end
 
  def resource
    @resource ||= User.new
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end




  def games
    if !user_signed_in?
      redirect_to '/home'
    else
      # temporary redirection
      unless flash[:notice]
        flash[:notice] = ''
      end
      flash[:notice] += "\nGames page is currently under construction. Check our blog and forums for the latest updates!"
      redirect_to edit_user_registration_url
    end
  end


  def companies
    render :layout => false
  end

  def landing_page
    if user_signed_in?
      redirect_to root_path
    end
  end

  def mail
    logger.info "company mail" + params[:name] + params[:email] + params[:org] + params[:game] + params[:app_store_link] + params[:google_play_link] + params[:message]
    begin
      MyMailer.notification_email(params[:name], params[:email], params[:org], params[:game] + params[:app_store_link] + params[:google_play_link] + params[:message]).deliver_now
      if flash[:notice]
        flash[:notice] += "Thanks for the message! We will contact you shortly.\n"
      else
        flash[:notice] = "Thanks for the message! We will contact you shortly.\n"
      end
    
    rescue  => e # in case redemption fails
      logger.error e.message
      logger.error e.backtrace.join("\n") 
      # error message
      if flash[:alert]
        flash[:alert] += "\nSending mail failed. Please try again later or email info@willowflare.com"
      else
        flash[:alert] = "Sending mail failed. Please try again later or email info@willowflare.com"
      end
    end


    redirect_to :back
  end


  def redirect_if_china
    # logger.info "geoip"
    # logger.info request.headers['X_GEOIP_COUNTRY_CODE']
    # logger.info request.headers['X_GEOIP_COUNTRY_ID']

    if request.headers['X_GEOIP_COUNTRY_CODE'] == "CN"
      redirect_to "/companies"
      return
    # else
    #   redirect_to "/store"
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
    devise_parameter_sanitizer.for(:sign_up) << :money
    devise_parameter_sanitizer.for(:sign_up) << :auth_level
    devise_parameter_sanitizer.for(:sign_up) << :info
    devise_parameter_sanitizer.for(:sign_up) << :news
    devise_parameter_sanitizer.for(:sign_up) << :referral
    devise_parameter_sanitizer.for(:account_update) << :username
    devise_parameter_sanitizer.for(:account_update) << :money
    devise_parameter_sanitizer.for(:account_update) << :auth_level
    devise_parameter_sanitizer.for(:account_update) << :gender
    devise_parameter_sanitizer.for(:account_update) << :age
    devise_parameter_sanitizer.for(:account_update) << :device
    devise_parameter_sanitizer.for(:account_update) << :OS
    devise_parameter_sanitizer.for(:account_update) << :time_spent
    devise_parameter_sanitizer.for(:account_update) << :spending
    devise_parameter_sanitizer.for(:account_update) << :motivation
    devise_parameter_sanitizer.for(:account_update) << :paying_incentive
    devise_parameter_sanitizer.for(:account_update) << :game_genre
    devise_parameter_sanitizer.for(:account_update) << :nation
    devise_parameter_sanitizer.for(:account_update) << :info
    devise_parameter_sanitizer.for(:account_update) << :num_games
    devise_parameter_sanitizer.for(:account_update) << :fav_game
    devise_parameter_sanitizer.for(:account_update) << :news
  end




  private
  # override the devise helper to store the current location so we can
  # redirect to it after loggin in or out. This override makes signing in
  # and signing up work automatically.
  def store_current_location
    store_location_for(:user, request.url)
  end





  # Use this to return to previous page after sign out

  # override the devise method for where to go after signing out because theirs
  # always goes to the root path. Because devise uses a session variable and
  # the session is destroyed on log out, we need to use request.referrer
  # root_path is there as a backup
  # def after_sign_out_path_for(resource)
  #   request.referrer || root_path
  # end
end
