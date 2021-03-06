class RegistrationsController < Devise::RegistrationsController
  #layout '__application', except: [:edit, :store, :update]

  # map referral emails to ID
  # Tried to do some fancy stuff by storing referral as an integer
  # but it gets messy with various callbacks
  # storing it as stirng (email) turns out to be easier
 #  def create
 #  	super do |resource|
 #  		if resource.referral != nil
	# 	    begin
	# 	    	resource.referral = User.where(email: params[:user][:referral])[0].id # get User ID of the referral
	# 	    rescue
	# 	    	resource.referral = -1 # error finding referral
	# 	    	resource.errors.add(:referral, "email not found. Please check you've entered it correctly or leave it blank")
	# 	    end
	# 	    resource.save
	# 	end
	# end
 #  end

  def edit
    super
  end

  # def update
  #   begin
  #     super
  #   rescue
  #     redirect_to after_update_path_for(resource), :flash => { :alert => "Error!" }
  #   end
  # end

  def store
  end


  def store_confirm
    if !current_user
      if flash[:alert]
        flash[:alert] += "\nYou're not logged in."
      else
        flash[:alert] = "You're not logged in."
      end

      redirect_to '/store' and return
    end

    begin
      @item_num = params[:item].to_i

      if current_user.money < Rails.application.config.STORE_ITEM_PRICE[@item_num]
        throw "redemption error, not enough money"
      end

      session[:social_share_msg] = "I just redeemed a " + Rails.application.config.STORE_ITEM_DESCRIPTION[@item_num] + " just by playing mobile games and giving feedback! Checkout WillowFlare here: www.willowflare.com"

    rescue  => e # in case redemption fails
      logger.error e.message
      logger.error e.backtrace.join("\n") 
      logger.info "Not enough money\n\n"
      logger.info @item_num
      logger.info current_user
      # error message
      if flash[:alert]
        flash[:alert] += "\nNot enough WillowPoints. Check the annoucement page for the newest updates and ways to earn rewards."
      else
        flash[:alert] = "Not enough WillowPoints. Check the annoucement page for the newest updates and ways to earn rewards."
      end

      redirect_to '/store' # redirect as a get request, handled by store controler/view
    end
  end



  def store_redeem
  	puts "redeeeeeem"
  	begin
  		@item_num = params[:redeem][:item].to_i
      @country = params[:redeem][:country]
      @comments = params[:redeem][:comments]

  		current_user.money -= Rails.application.config.STORE_ITEM_PRICE[@item_num] # get item price
  		if current_user.money < 0
  			throw "redemption error, not enough money"
  		end
  		current_user.info += ", redeemed " + Rails.application.config.STORE_ITEM_DESCRIPTION[@item_num] + " for " + @country + " at " + Time.new.inspect
		
  		MyMailer.store_redeem_email(current_user, @item_num, @country, @comments).deliver_now
  		
  		if flash[:notice]
  			flash[:notice] += "\nThanks for redeeming! We will send out the reward to " + current_user.email + " in the next 48 hours."
  		else
  			flash[:notice] = "\nThanks for redeeming! We will send out the reward to " + current_user.email + " in the next 48 hours."
  		end
  		current_user.save
  	
  	rescue  => e # in case redemption fails
  		logger.error e.message
		  logger.error e.backtrace.join("\n") 
  		puts "Store Redemption Error\n\n"
  		puts @item_num
  		puts current_user.money
  		# error message
  		if flash[:error]
  			flash[:error] += "\nStore redemption error. Please check you have enough points and contact player support for assistance."
  		else
  			flash[:error] = "Store redemption error. Please check you have enough points and contact player support for assistance."
  		end
  	end
  	redirect_to '/store' # redirect as a get request, handled by store controler/view
  end
  

  protected

  def update_resource(resource, params)
    
  	# reward for completing their profile
  	if resource.info == nil or !(resource.info.include? "profile")
	  	t = 1
	  	# make sure they've filled everything
	  	params.except(:password, :password_confirmation, :current_password).each do |p|
	  		puts p
	  		if p[1].blank?
	  			t = 0
	  		end
	  	end

	  	# for some reason this skips gender if it's unchecked, since it's a radio button (?)

	  	if t == 1
	  		resource.money += 15
	  		if resource.info == nil
		        resource.info = 'profile_completed'
		      else
		        resource.info += ', profile_completed'
	      	end
	  	end
    end


    # allow update w/o changing pw
  	if params[:password].blank? && params[:password_confirmation].blank?
    	resource.update_without_password(params)
    else
    	super
    end
  end


  # redirect back to "Accounts" page after update
  def after_update_path_for(resource)
    edit_user_registration_path
  end


  # redirect to "welcome" page after sign-up; this is for email confirmations
  def after_inactive_sign_up_path_for(resource)
    welcome_index_path
  end

  # non-confirmations (e.g. OAuth)
  def after_sign_up_path_for(resource)
    welcome_index_path
  end



  private

  def user_params
  	params.require(:user).permit(:email, :username, :password, :password_confirmation)
  end
end