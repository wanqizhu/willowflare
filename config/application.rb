require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)


module RedditClone
  class Application < Rails::Application
    
    config.to_prepare do
      # Load application's model / class decorators
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end

      # Load application's view overrides
      Dir.glob(File.join(File.dirname(__FILE__), "../app/overrides/*.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

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
    Dir.chdir(File.dirname(__FILE__))
    config.mailchimp_signup = File.readlines('mailchimp_email.txt').each {|l| l.chomp!}.collect {|el| el.downcase }
    config.admins = File.readlines('admin_email.txt').each {|l| l.chomp!}.collect {|el| el.downcase }
    config.survey001 = File.readlines('survey001.txt').each {|l| l.chomp!}.collect {|el| el.downcase }
    config.survey001_winners = File.readlines('survey001_winners.txt').each {|l| l.chomp!}.collect {|el| el.downcase }
    config.survey002 = File.readlines('survey002.txt').each {|l| l.chomp!}.collect {|el| el.downcase }
    config.survey003 = File.readlines('survey003.txt').each {|l| l.chomp!}.collect {|el| el.downcase }


    Dir.chdir(Rails.root)


    # read in env files for mailer
    config.before_configuration do
        env_file = File.join(Rails.root, 'config', 'local_env.yml')
        YAML.load(File.open(env_file)).each do |key, value|
            ENV[key.to_s] = value
        end if File.exists?(env_file)
    end


    # mailchimp subscribe object
    config.mailchimp = Mailchimp::API.new(ENV["MAILCHIMP_API_KEY"])

  end
end
