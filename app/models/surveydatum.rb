class Surveydatum < ActiveRecord::Base

	before_create :log_survey


	def log_survey
		if self.reward == nil or self.reward < 0
			self.reward = 0
		end

		if self.email == nil
			return
		end

		# This is pretty insecure lOL
		# prepad the survey # with a secret key
		# only this type of post-requests will be accepted
		len = ENV["SECRET_SURVEY_KEY"].length
		if self.surveyresponse == nil or self.surveyresponse.length <= len or self.surveyresponse[0, len] != ENV["SECRET_SURVEY_KEY"]
			return
		end


		survey_num = self.surveyresponse[len]
		surveyresponse = 'Survey ' + surveyresponse[len..-1]
		
		if 0 > survey_num.to_i or survey_num.to_i > ENV["MAX_SURVEY_NUM"].to_i
			return
		end

		u = User.where(email: self.email)[0]

		# Check the user hasn't already completed the survey
		if u != nil
			if (u.info == nil or !u.info.include?('survey'+survey_num))
				if u.info == nil
					u.info = 'surveydata_recorded_Reward_' + self.reward.to_s + '_At_' + Time.new.inspect + ', survey' + survey_num + '_completed'
				else
					u.info += ', surveydata_recorded_Reward_' + self.reward.to_s + '_At_' + Time.new.inspect + ', survey' + survey_num + '_completed'

				end

				u.money += self.reward
				if u.news != nil
					u.news += ' Thanks for completing survey #' + survey_num + "! You've been rewarded with " + self.reward.to_s + " points.\n"
				else
					u.news = ' Thanks for completing survey #' + survey_num + "! You've been rewarded with " + self.reward.to_s + " points.\n"
				end

				u.save


				puts u.money
				puts u.info
				puts u.id
			else
				puts "ALREADY_COMPLETED\n\n"
				puts self.email + "\n\n"
				puts self.surveyresponse + "\n\n"
			end
		else # In case the user doesn't exist yet
			File.open(Rails.root + ('config/survey00' + survey_num + '.txt'), 'a') { |f|
				f.write(self.email + "\n")
			}
		end


	end
end
