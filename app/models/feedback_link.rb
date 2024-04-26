class FeedbackLink < ApplicationRecord
  belongs_to :participant

  before_create :generate_token

  private

  def generate_token
    self.token = SecureRandom.uuid
  end
end
