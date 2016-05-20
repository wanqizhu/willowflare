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


  NATION_ = %w[USA  UK  Rest of Europe  Latin_America Asia]
  enum nation: NATION_




  before_create :init_user

  def init_user

    self.email = self.email.downcase


    if Rails.application.config.mailchimp_signup.include?(self.email)
      self.money = 50
      if self.info == nil
        self.info = 'beta_signup'
      else
        self.info += ', beta_signup'
      end
    else
      self.money = 0
    end

    if Rails.application.config.survey001.include?(self.email)
      self.money += 35
      if self.info == nil
        self.info = 'survey1_completed'
      else
        self.info += ', survey1_completed'
      end
    end

    if Rails.application.config.survey001_winners.include?(self.email)
      self.money += 100
    end

    if Rails.application.config.survey002.include?(self.email)
      self.money += 60
      if self.info == nil
        self.info = 'survey2_completed'
      else
        self.info += ', survey2_completed'
      end
    end


    if Rails.application.config.admins.include?(self.email)
      self.auth_level = 99
    else
      self.auth_level = 0
    end
  end

end
