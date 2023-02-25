class Reply < ApplicationRecord
  validates :body, presence: true, length: { minimum: 2, maximum: 150 }
  validates :user_id, presence: true
  validates :suggestion_id, presence: true

  belongs_to :suggestion
  belongs_to :user
end
