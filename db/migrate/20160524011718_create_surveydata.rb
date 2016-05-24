class CreateSurveydata < ActiveRecord::Migration
  def change
  	drop_table(:surveydata, if_exists: true) 

    create_table :surveydata do |t|
      t.string :email
      t.text :surveyresponse

      t.timestamps null: false
    end
  end
end
