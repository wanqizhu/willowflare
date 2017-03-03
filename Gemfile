source 'https://rubygems.org'
ruby ENV['LIVE_RUBY_VERSION'] || ENV['LOCAL_RUBY_VERSION'] || '2.0.0'



## frontend design gems
gem 'simple_form', '~> 3.2', '>= 3.2.1'
gem 'font-awesome-rails', '~> 4.6', '>= 4.6.1.0'
gem 'social-share-button'
gem 'haml'
gem 'wow-rails'
gem 'bxslider-rails'

# Use SCSS for stylesheets
gem 'bootstrap-sass', '~> 3.3.6'
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-easing-rails'
gem 'jquery-ui-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'



# upload files
gem 'carrierwave', github: 'carrierwaveuploader/carrierwave'
gem 'mini_magick'




## functionality gems
gem 'acts_as_votable', '~> 0.10.0'
gem 'mailchimp-api', require: 'mailchimp'

# for redirecitng China traffic
gem 'rack-geoipcountry', '~> 1.0', '>= 1.0.2'
# for blacklisting
gem 'rack-attack', '~> 5.0.0.beta1'


# blog
gem 'monologue', '>= 0.5.0'
gem 'responders', '~> 2.1.0'

# forums
gem 'thredded', '~> 0.6.1'


# nice console printing
# USAGE: ap User.last
gem "awesome_print", require:"ap"


# omniauth logins
gem 'omniauth-facebook'
gem "omniauth-google-oauth2"

# for AWS
gem 'puma'
gem 'mysql2', '~> 0.3.18'


## development gems

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.2.0'
# Use sqlite3 as the local database for Active Record
gem 'sqlite3'


# exception handling
gem 'exception_notification'

# schedule cron jobs
gem 'whenever', :require => false


# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby


# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
# Added by wzich on 20150125 at 18:04:45 for user management
gem 'devise', '~> 3.4.1'


# for dumping existing db into seed
gem 'seed_dump'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'web-console', '~> 2.0', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Call 'binding.pry' anywhere in a Controller to call up a shell to debug
  # alternate to byebug (see pry-byebug when there's time)
  gem "pry-rails"

  # support for Chrome extension RailsPanel
  gem 'meta_request'

  gem "better_errors" # better errors

  # Access an IRB console on exception pages or by using <%= console %> in views

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

