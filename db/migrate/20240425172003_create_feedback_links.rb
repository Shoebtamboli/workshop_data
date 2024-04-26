class CreateFeedbackLinks < ActiveRecord::Migration[7.1]
  def change
    create_table :feedback_links do |t|
      t.references :participant, null: false, foreign_key: true
      t.text :feedback
      t.datetime :expires_at

      t.timestamps
    end
  end
end
