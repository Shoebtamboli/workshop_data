class Participant < ApplicationRecord
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true

    has_one :feedback_link, dependent: :destroy
  end