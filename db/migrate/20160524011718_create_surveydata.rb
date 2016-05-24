class CreateSurveydata < ActiveRecord::Migration
  def change
  	drop_table 'surveydata' if ActiveRecord::Base.connection.table_exists? 'surveydata'

    create_table :surveydata do |t|
      t.string :email
      t.text :surveyresponse

      t.timestamps null: false
    end
  end
end
