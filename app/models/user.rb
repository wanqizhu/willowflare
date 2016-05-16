class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :links

  before_create :init_user

  def init_user
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
      self.money += 50
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
