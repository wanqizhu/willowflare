class SessionsController < Devise::SessionsController
  before_filter :before_login, :only => :create
  after_filter :after_login, :only => :create

  def before_login
  end

  # show news message, if present
  def after_login
    if resource.news != nil
    	if flash[:notice]
    		flash[:notice] += ' ' + resource.news
    	else
    		flash[:notice] = ' ' + resource.news
    	end
    end

  	resource.news = ""
  	resource.save
  end
end