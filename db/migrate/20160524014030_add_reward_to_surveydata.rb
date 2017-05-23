class AddRewardToSurveydata < ActiveRecord::Migration
  def change
    add_column :surveydata, :reward, :integer
  end
end
