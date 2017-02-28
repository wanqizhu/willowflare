class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable
  devise :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]

  has_many :links




  attr_accessor :current_password

  AGE_ = %w[<_18    18-24   25-45   >_45]
  enum age: AGE_

  GENDER_ = %w[Male   Female]
  enum gender: GENDER_

  DEVICE_ = %w[Smartphone_only   Tablet_only   Smartphone_and_tablet]
  enum device: DEVICE_

  OS_ = %w[iPhone   Android    iPad   Other]
  enum OS: OS_


  TIME_SPENT_ = %w[<_1h   1-5h  >_5h]
  enum time_spent: TIME_SPENT_

  SPENDING_ = %w[0  $1-10   >_$10]
  enum spending: SPENDING_


  MOTIVATION_ = %w[pass_time_while_waiting  relax  take_a_break  challenge_myself interested_in_the_story_or_art  cheap_or_free_game]
  enum motivation: MOTIVATION_


  PAYING_INCENTIVE_ = %w[New_levels/content   Speed_up_progress   VIP_Access    Increase_competitiveness    Aesthetics/better_experience]
  enum paying_incentive: PAYING_INCENTIVE_
  

  GAME_GENRE_ = %w[Action  Strategy  Simulation  RPG    Puzzle  Sports  Arcade]
  enum game_genre: GAME_GENRE_


  NATION_ = %w[USA  UK  Rest_of_Europe  Latin_America Asia]
  enum nation: NATION_


  validate :check_referral
  validates_uniqueness_of :username


  before_create :init_user

  after_update :check_points

  # display the username in views that use @user.to_s, instead of #<User:0x007f9566ce3dc8>
  def to_s
    username
  end


  # custom forum moderator permission
  def thredded_can_moderate_messageboards
    self.auth_level > 90 ? Thredded::Messageboard.all : Thredded::Messageboard.none
  end

  def thredded_admin?
    return self.auth_level > 90
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.username = auth.info.name   # assuming the user model has a name
      #user.image = auth.info.image # assuming the user model has an image
    end
  end



  protected

  def check_referral
    if self.referral != nil and !self.referral.empty? and !User.exists?(email: self.referral) and !User.exists?(username: self.referral) 
      errors.add(:referral, " not found. Please check you've entered it correctly or leave it blank")
      return false
    end

    # make sure username doesn't start with $
    if self.username[0] == '$'
      errors.add(:username, "invalid, please try something else.")
      return false
    end
  end


  # give referral awards ONLY IF they have 100 points and have completed a survey, to prevent spam referrals
  def check_points
    begin # just incase errors
      
      if self.confirmed? and self.referral != nil and self.info.include?('referred by $') and self.info.include?('survey') and self.money >= 100
        #puts self.email
        logger.info "User " + self.email + " has completed their referral requirements to grant reward to " + self.referral
        
        self.info = self.info.gsub('referred by $', 'referred by ')
        #puts self.info

        u = User.where(email: self.referral)[0]
        if u == nil
          u = User.where(username: self.referral)[0]
        end

        if u != nil and u.info.include?('referred towards $' + self.email)
          #puts u.email

          logger.info "User " + u.email + " has earned their reward for referring " + self.email

          u.info = u.info.gsub('referred towards $' + self.email, 'referred towards ' + self.email)
          #puts u.info

          u.news += "Thanks for referring " + self.email + "! You have receive 30 points thanks to his/her activities."
          u.money += 30
          u.save

        end
      end


      # League of Tyroria Promo: 2/21 - 2/28
      if !self.info.include?('League of Tyroria 30 pts promo')
        if Time.now.getutc.to_i > 1487695791 and Time.now.getutc.to_i < 1488300651
          self.money += 30
          self.info += ", League of Tyroria 30 pts promo, "
          self.save
        end
      end


    rescue => e
      logger.error e.message
      logger.error e.backtrace.join("\n") 

    end
  end




  def init_user

    self.email = self.email.downcase
    self.news = "If you haven't already, please complete your profile by navigating to 'Account' page and earn 15 WillowPoints!"
    self.info = ""


    #if Rails.application.config.mailchimp_signup.include?(self.email)
      self.money = 50
      self.info += 'beta_signup'
    # else
    #   self.money = 0
    # end


    # League of Tyroria Promo: 2/21 - 3/7

    if Time.now.getutc.to_i > 1487695791 and Time.now.getutc.to_i < 1487695791 + 604860 * 2
      self.money += 30
      self.info += ", League of Tyroria 30 pts promo, "
    end


    # if Rails.application.config.survey001.include?(self.email)
    #   self.money += 35
      
    #   self.info += ', survey1_completed'
    # end

    # if Rails.application.config.survey001_winners.include?(self.email)
    #   self.money += 100
    # end

    # if Rails.application.config.survey002.include?(self.email)
    #   self.money += 60

    #   self.info += ', survey2_completed'
    # end


    # if Rails.application.config.survey003.include?(self.email)
    #   self.money += 75

    #   self.info += ', survey3_completed'
    # end

    # if Rails.application.config.survey004.include?(self.email)
    #   self.money += 35

    #   self.info += ', survey4_completed'
    # end

    # if Rails.application.config.survey005.include?(self.email)
    #   self.money += 35

    #   self.info += ', survey5_completed'
    # end


    if self.referral != nil and !self.referral.empty?
      


      referrer = User.where(email: self.referral)[0]

      if referrer != nil
        self.money += 30
        self.info += ', referred by $' + self.referral

        #referrer.money += 30
        referrer.news += "Thanks for referring " + self.email + "! You will receive 30 bonus points upon his/her profile completion and filling out at least one survey."
        referrer.info += ', referred towards $' + self.email
        referrer.save
      else
        referrer = User.where(username: self.referral)[0]
        

        if referrer != nil
          self.money += 30
          self.info += ', referred by $' + self.referral

          #referrer.money += 30
          referrer.news += "Thanks for referring " + self.email + "! You will receive 30 bonus points upon his/her profile completion and filling out at least one survey."
          referrer.info += ', referred towards $' + self.email
          referrer.save
        end
      end
      
    end


    if Rails.application.config.admins.include?(self.email)
      self.auth_level = 99
    else
      self.auth_level = 0
    end

    # subscribe to mailing list, BUT ONLY IN PRODUCTION
    begin
      # subscribe with double-optin = false, update_existing = true, send_welcome = true
      # the parameters are
      # id, email, merge_vars, email_type, double_optin, update_existing, replace_interests, send_welcome
      if Rails.env.production?
        Rails.application.config.mailchimp.lists.subscribe(ENV["MAILCHIMP_LIST_ID"], {email: self.email}, nil, 'html', false, true, true, true)
      else
        raise 'dev environment'
      end
    rescue => e
      self.info += ", CANNOT SUBSCRIBE TO MAILCHIMP"
      logger.error e.message
      if (e.message != 'dev environment')
        logger.error e.backtrace.join("\n") 
      end
    end

  end




end
