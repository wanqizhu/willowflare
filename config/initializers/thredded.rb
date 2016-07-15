# frozen_string_literal: true
# Thredded configuration

# ==> User Configuration
# The name of the class your app uses for your users.
# By default the engine will use 'User' but if you have another name
# for your user class - change it here.
Thredded.user_class = 'User'

# User name column, used in @mention syntax and should be unique.
# This is the column used to search for users' names if/when someone is @ mentioned.
Thredded.user_name_column = :username

# The path (or URL) you will use to link to your users' profiles.
Thredded.user_path = ->(user) { "/users/#{user.username}" }

# This method is used by Thredded controllers and views to fetch the currently signed-in user
Thredded.current_user_method = :"current_#{Thredded.user_class.name.underscore}"

# User avatar URL. rb-gravatar gem is used by default:
Thredded.avatar_url = ->(user) { Gravatar.src(user.email, 128, 'mm') }

# ==> Permissions Configuration
# By default, thredded uses a simple permission model, where all the users can post to all message boards,
# and admins and moderators are determined by a flag on the users table.

# The name of the moderator flag column on the users table.
Thredded.moderator_column = :auth_level
# The name of the admin flag column on the users table.
Thredded.admin_column = :auth_level

# Whether posts and topics pending moderation are visible to regular users.
Thredded.content_visible_while_pending_moderation = true

# This model can be customized further by overriding a handful of methods on the User model.
# For more information, see app/models/thredded/user_extender.rb.

# ==> Email Configuration
# Email "From:" field will use the following
Thredded.email_from = 'info@willowflare.com'

# Incoming email will be directed to this host
Thredded.email_incoming_host = 'willowflare.com'

# Emails going out will prefix the "Subject:" with the following string
Thredded.email_outgoing_prefix = '[WillowFlare Forum] '

# Reply to field for email notifications
Thredded.email_reply_to = -> postable { "#{postable.hash_id}@#{Thredded.email_incoming_host}" }

# ==> View Configuration
# Set the layout for rendering the thredded views.
Thredded.layout = 'thredded/application'

# ==> Post Content Formatting
# Customize the way Thredded handles post formatting.

# Change the default html-pipeline filters used by thredded.
# E.g. to remove BBCode support:
# Thredded::ContentFormatter.pipeline_filters -= [HTML::Pipeline::BbcodeFilter]

# Change the HTML sanitization settings used by Thredded.
# See the Sanitize docs for more information on the underlying library: https://github.com/rgrove/sanitize/#readme
# E.g. to allow a custom element <custom-element>:
# Thredded::ContentFormatter.whitelist[:elements] += %w(custom-element)

# ==> Error Handling
# By default Thredded just renders a flash alert on errors such as Topic not found, or Login required.
# Below is an example of overriding the default behavior on LoginRequired:
#
# Rails.application.config.to_prepare do
#   Thredded::ApplicationController.module_eval do
#     rescue_from Thredded::Errors::LoginRequired do |exception|
#       @message = exception.message
#       render template: 'sessions/new', status: :forbidden
#     end
#   end
# end
