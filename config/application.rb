require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)


module RedditClone
  class Application < Rails::Application
    config.middleware.use Rack::Attack
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true


    #config.paths['app/views'] << 'app/views/devise' # keep devise views, even though we customize registration controller


    # email lists
    # read in each file as a list if it exists
    # these are used to store users who completed the survey w/o an account already
    Dir.chdir(File.dirname(__FILE__))
    config.mailchimp_signup = File.readlines('mailchimp_email.txt').each {|l| l.chomp!}.collect {|el| el.downcase }
    config.admins = File.readlines('admin_email.txt').each {|l| l.chomp!}.collect {|el| el.downcase }
    config.survey001 = File.readlines('survey001.txt').each {|l| l.chomp!}.collect {|el| el.downcase }
    config.survey001_winners = File.readlines('survey001_winners.txt').each {|l| l.chomp!}.collect {|el| el.downcase }
    config.survey002 = File.readlines('survey002.txt').each {|l| l.chomp!}.collect {|el| el.downcase }
    config.survey003 = ((File.readlines('survey003.txt').each {|l| l.chomp!}.collect {|el| el.downcase } if File.exists?('survey003.txt')) || [])
    config.survey004 = ((File.readlines('survey004.txt').each {|l| l.chomp!}.collect {|el| el.downcase } if File.exists?('survey004.txt')) || [])
    config.survey005 = ((File.readlines('survey005.txt').each {|l| l.chomp!}.collect {|el| el.downcase } if File.exists?('survey005.txt')) || [])


    Dir.chdir(Rails.root)


    # read in env files
    config.before_configuration do
        env_file = File.join(Rails.root, 'config', 'local_env.yml')
        begin
            YAML.load(File.open(env_file)).each do |key, value|
                ENV[key.to_s] = value
            end if File.exists?(env_file)
        rescue
            puts 'Error loading environment variables'
        end
    end



    # Store stuff -- should go into separate MVC, but for now we'll store it here
    config.STORE_ITEM_NAME = ["rp-gift-card.png", "google-play-gift-card.jpg", "itunes-gift-card.jpg", "amazon-gift-card.png"]
    config.STORE_ITEM_PRICE = [450, 500, 500, 500]
    config.STORE_ITEM_DESCRIPTION = ["$10 RP Card", "$10 Google Play Gift Card", "$10 Itunes Gift Card", "$10 Amazon Gift Card"]
    
   
  end
end

# override the lib file to add config.blog_name
require "#{Rails.root}/lib/monologue/configuration.rb"
