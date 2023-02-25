class Report < ApplicationRecord
  validates :reason, presence: true, length: { minimum: 10, maximum: 500 }
  validates :user_id, presence: true
  validates :reportable_type, presence: true
  validates :reportable_id, presence: true

  belongs_to :user
  belongs_to :reportable, polymorphic: true

  delegate :name, to: :user, prefix: true
end
