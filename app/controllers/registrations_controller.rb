# update user w/o password
class RegistrationsController < Devise::RegistrationsController

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
end