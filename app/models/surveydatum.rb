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

		if self.surveyresponse == nil or self.surveyresponse.length < 11 or self.surveyresponse[0, 10] != "SECR3T_KEY"
			return
		end


		survey_num = self.surveyresponse[10]
		
		if '0' > survey_num or survey_num > '4'
			return
		end

		u = User.where(email: self.email)[0]

		# Check the user hasn't already completed the survey
		if u != nil and (u.info == nil or !u.info.include?('survey'+survey_num))
			if u.info == nil
				u.info = 'surveydata_recorded_reward: ' + self.reward.to_s + '_at ' + Time.new.inspect + ', survey' + survey_num + '_completed'
			else
				u.info += ', surveydata_recorded_reward: ' + self.reward.to_s + '_at ' + Time.new.inspect + ', survey' + survey_num + '_completed'

			end

			u.money += self.reward
			if u.news != nil
				u.news += ' Thanks for completing survey #' + survey_num + "! You've been rewarded with " + self.reward.to_s + "points.\n"
			else
				u.news = ' Thanks for completing survey #' + survey_num + "! You've been rewarded with " + self.reward.to_s + "points.\n"
			end

			u.save


			puts u.money
			puts u.info
			puts u.id
		else
			puts "NIL\n\n"
			puts self.email + "\n\n"
		end


	end
end
