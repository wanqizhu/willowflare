class MyMailer < Devise::Mailer   
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views

  default from: 'info@willowflare.com'

  def store_redeem_email(user, item)
  	@user = user
  	@item = item
  	mail(to: "info@willowflare.com", cc: Rails.application.config.admins, subject: "Store redemption by " + @user.email + " for " + Rails.application.config.STORE_ITEM_DESCRIPTION[@item])
  end 
end
