class Like < ApplicationRecord
  validates :likeable_type, presence: true
  validates :likeable_id, presence: true
  validates :user_id, presence: true
  validates :user_id, uniqueness: { scope: %i[likeable_id likeable_type] }

  belongs_to :user
  belongs_to :likeable, polymorphic: true

  scope :recent_like, -> { order(id: :desc).limit(5) }

  delegate :name, to: :user, prefix: true
end
