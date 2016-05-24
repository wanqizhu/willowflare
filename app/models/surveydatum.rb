class Surveydatum < ActiveRecord::Base

	before_create :log_survey


	def log_survey
		if self.reward == nil
			self.reward = 0
		end

		if self.email == nil
			return
		end



		u = User.where(email: self.email)[0]

		if u != nil
			if u.info == nil
				u.info = 'surveydata_recorded, reward: ' + self.reward.to_s + ', at ' + Time.new.inspect
			else
				u.info += ', surveydata_recorded, reward: ' + self.reward.to_s + ', at ' + Time.new.inspect
			end
			u.money += self.reward
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
