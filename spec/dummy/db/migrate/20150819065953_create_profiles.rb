class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string    :first_name
      t.string    :last_name
      t.string    :email

      t.string    :utm_source
      t.string    :utm_medium
      t.string    :utm_term
      t.string    :utm_content
      t.string    :utm_campaign

      t.string    :survey_name
      t.datetime  :survey_completed_at
      t.datetime  :survey_started_at
      t.datetime  :permission_given_at

      t.timestamps

    end
  end
end
