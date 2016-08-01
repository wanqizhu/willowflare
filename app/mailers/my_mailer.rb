class MyMailer < Devise::Mailer   
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views

  default from: 'info@willowflare.com'

  def store_redeem_email(user, item, country, comments)
  	@user = user
  	@item = item
    @comments = comments
  	if Rails.env.development? | Rails.env.test?
  		mail(to: "info@willowflare.com", subject: "[TEST] Store redemption by " + @user.email + " for " + Rails.application.config.STORE_ITEM_DESCRIPTION[@item] + ", " + country)
  	else
		  mail(to: "info@willowflare.com", cc: Rails.application.config.admins, subject: "Store redemption by " + @user.email + " for " + Rails.application.config.STORE_ITEM_DESCRIPTION[@item] + ", " + country)
  	end
  end 


  def notification_email(name, email, org, message)
    @name = name
    @message = message
    @email = email
    @org = org
    if Rails.env.development? | Rails.env.test?
      mail(to: "info@willowflare.com", subject: "[TEST] New email from " + @name + @email + @org)
    else
      mail(to: "info@willowflare.com", subject: "New email from " + @name + @email + @org)
    end
  end
end
