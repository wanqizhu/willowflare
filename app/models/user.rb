class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

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


  before_create :init_user




  protected

  def check_referral
    if self.referral != nil and !self.referral.empty? and !User.exists?(email: self.referral) and !User.exists?(username: self.referral) 
      errors.add(:referral, "email not found. Please check you've entered it correctly or leave it blank")
      return false
    end
  end








  def init_user

    self.email = self.email.downcase
    self.news = "If you haven't already, please complete your profile by navigating to 'Account' page and earn 15 WillowPoints!"
    self.info = ""


    #if Rails.application.config.mailchimp_signup.include?(self.email)
      self.money = 50
      self.info += ', beta_signup'
    # else
    #   self.money = 0
    # end

    if Rails.application.config.survey001.include?(self.email)
      self.money += 35
      
      self.info += ', survey1_completed'
    end

    if Rails.application.config.survey001_winners.include?(self.email)
      self.money += 100
    end

    if Rails.application.config.survey002.include?(self.email)
      self.money += 60

      self.info += ', survey2_completed'
    end


    if Rails.application.config.survey003.include?(self.email)
      self.money += 75

      self.info += ', survey3_completed'
    end




    if self.referral != nil and !self.referral.empty?
      self.money += 30

      referrer = User.where(email: self.referral)[0]

      if referrer != nil
        referrer.money += 30
        referrer.news += " You have earned 30 points thanks to your referral to " + self.email
        referrer.save
      else
        referrer = User.where(username: self.referral)[0]

        if referrer != nil
          referrer.money += 30
          referrer.news += " You have earned 30 points thanks to your referral to " + self.email
          referrer.save
        end
      end
      
    end


    if Rails.application.config.admins.include?(self.email)
      self.auth_level = 99
    else
      self.auth_level = 0
    end

    # subscribe to mailing list
    begin
      # subscribe with double-optin = false, update_existing = true, send_welcome = true
      # the parameters are
      # id, email, merge_vars, email_type, double_optin, update_existing, replace_interests, send_welcome
      Rails.application.config.mailchimp.lists.subscribe(ENV["MAILCHIMP_LIST_ID"], {email: self.email}, nil, 'html', false, true, true, true)
    rescue
      self.info += ", CANNOT SUBSCRIBE TO MAILCHIMP"
    end

  end




end
