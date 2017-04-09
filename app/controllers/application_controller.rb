class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # saves username
  # see STRONG validation in Device documentation
  before_filter :configure_permitted_parameters, if: :devise_controller?

  # send additional data via exception_notifier gem in case of exceptions
  before_filter :prepare_exception_notifier


  # saves the location before loading each page so we can return to the
  # right page. If we're on a devise page, we don't want to store that as the
  # place to return to (for example, we don't want to return to the sign in page
  # after signing in), which is what the :unless prevents
  before_filter :store_current_location, :unless => :devise_controller?

  use Rack::GeoIPCountry, :db => File.expand_path(Rails.root.join("db/GeoIP.dat"))
  before_filter :redirect_if_china, :except => [:companies, :landing_page]

  before_filter :get_mobile_device_type


  # helpers to enable sign-up form on the landing page
  helper_method :resource_name, :resource, :devise_mapping


  # load up games
  before_action :load_games, :only => [:ourgames, :games, :game_detail]



  def resource_name
    :user
  end
 
  def resource
    @resource ||= User.new
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end



  def about
  end


  def games
    if !user_signed_in?
      redirect_to '/home' and return
    else
      
      # call load_games
      

      #flash[:notice] = "Games page is currently under construction. Please pardon our dust!"
    #   redirect_to edit_user_registration_url
    end
  end

  def ourgames
  end


  def game_detail
    # call load_games
    @game_num = params[:game_num].to_i

    @game = @games[@game_num]
    @survey = @surveys[@game_num]
    @link = @links[@game_num]
    @alt_link = @alt_links[@game_num]

    @player_num = (@count * @mult[@game_num] + @base[@game_num]).round
    @is_featured = (@featured[@game_num] == 1)

    @is_android = !@alt_link.blank?
    @is_ios = !@link.blank?

    #@featured = params[:featured]
    # gets all images of the form app-*.png to display on the game_detail page
    @images = Dir.glob("public/assets/files/games/#{@game}/app-*.{jpg,png}")
    # puts @images
  end




  # static pages

  def companies
    render :layout => false
  end

  def landing_page
    if user_signed_in?
      redirect_to root_path
    end
  end

  def welcome
  end 


  def private_policy
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

    # if request.headers['X_GEOIP_COUNTRY_CODE'] == "CN"
    #   redirect_to "/companies"
    #   return
    # # else
    # #   redirect_to "/store"
    # end
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


  # send user data with the exception-notification email
  def prepare_exception_notifier
    request.env["exception_notifier.exception_data"] = {
      :current_user => current_user
    }
  end


  def load_games
    # pre-registration numbers: count * mult + base
    @count = User.count
    @mult = [6.5, 0.7, 1.9, 0.9, 0.4, 0.75, 4.7]
    @base = [2350, 1100, 1337, 840, 750, 2000, 531]

    @games = ["Legend of Tyroria", "Clash of Kings"] #, "Emperor of Chaos", "Realm of Doom", "Mr. Q's Magnetic Adventure", "Tap Knights", "League of Angels", "Loong Craft"]
    @featured = [1, 0, 0, 0, 0, 0, 0, 0]
    # @android = [1, 1, 0, 1, 1, 1]
    # @ios = [1, 0, 1, 0, 1, 1]

    @surveys = ["https://goo.gl/forms/LByJEqNfoE6UVMpN2",
      "https://docs.google.com/forms/d/1DCo0-Rj6CW4cpp028s24kCZJUi8BzKvNp2vG6Ok-Zmk", 
      "", 
      "",
      "https://docs.google.com/forms/d/e/1FAIpQLScjekG2LvvI8bng7HFKiLrgt6WecIXsbMoTjunSqEBgzl0NHg/viewform",
      "https://docs.google.com/forms/d/e/1FAIpQLSdmqT-LGph1lYTUTYNcU8VxyqdbIRh-XFv2OvgSfd2-EGBzIg/viewform",
      "https://goo.gl/forms/d5GbPs9jcow7nAN02", 
      ""]

    # default: iOS
    @links = ["", 
      "https://itunes.apple.com/us/app/clash-of-kings-cok/id945274928?mt=8", 
      "https://itunes.apple.com/gb/app/emperor-of-chaos/id1173389729?mt=8", 
      "", 
      "https://itunes.apple.com/ph/app/mr.-q-magnetic-cube-arcade/id1140688701", 
      "",
      "https://itunes.apple.com/us/app/league-of-angels-fire-raiders/id930452496", 
      "https://itunes.apple.com/ph/app/loong-craft/id1104555626"]

    # default: Android
    @alt_links = ["https://app.appsflyer.com/com.stgl.global?pid=willowflare&c=willowflare_stgl_us_2_other_testcampaign", 
      "", 
      "https://play.google.com/store/apps/details?id=com.zloong.eu.eoc", 
      "https://play.google.com/store/apps/details?id=com.catmintgame.doomsday.googleplay&referrer=utm_source%3Dwillowflare%26utm_campaign%3Dwillowflarerealm",
      "", 
      "https://play.google.com/store/apps/details?id=cn.bettergame.tapknights", 
      "https://play.google.com/store/apps/details?id=com.gtarcade.loa.ph", 
      "https://play.google.com/store/apps/details?id=com.ujoy.d6en&hl=en"]
  


    @ourgames = ["Legend of Tyroria", "Emperor of Chaos", "Realm of Doom", "Mr. Q's Magnetic Adventure", "Venty"]

    @ourgames_appstore_links = ["", 
      "https://itunes.apple.com/gb/app/emperor-of-chaos/id1173389729?mt=8", 
      "", 
      "https://itunes.apple.com/ph/app/mr.-q-magnetic-cube-arcade/id1140688701",
      ""]

    # default: Android
    @ourgames_googleplay_links = ["https://app.appsflyer.com/com.stgl.global?pid=willowflare&c=willowflare_stgl_us_2_other_testcampaign", 
     "https://play.google.com/store/apps/details?id=com.zloong.eu.eoc", 
      "https://play.google.com/store/apps/details?id=com.catmintgame.doomsday.googleplay&referrer=utm_source%3Dwillowflare%26utm_campaign%3Dwillowflarerealm",
      "",
      ""]
  end




  def get_mobile_device_type
    # Not sure why we're still getting NIL errors
    begin
      if request.env['HTTP_USER_AGENT'].blank? or request.env['HTTP_USER_AGENT'] == nil
        @device = "unknown"
      elsif request.env['HTTP_USER_AGENT'].to_s.downcase.match(/android/)
        @device = "android"
      elsif request.env['HTTP_USER_AGENT'].to_s.downcase.match(/iphone|ipod/)
        @device = "ios"
      else
        @device = "unknown"
      end
    rescue => e
      logger.error e.message
      logger.error e.backtrace.join("\n")
      logger.info "application#get_mobile_device_type error: "
      logger.info(request.env)
      @device = "unknown"
    end
    #puts @device 
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
