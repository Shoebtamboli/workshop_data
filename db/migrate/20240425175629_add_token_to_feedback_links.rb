class AddTokenToFeedbackLinks < ActiveRecord::Migration[7.1]
  def change
    add_column :feedback_links, :token, :string
  end
end
