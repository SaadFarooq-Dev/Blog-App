class Suggestion < ApplicationRecord
  validates :title, presence: true, length: { minimum: 10, maximum: 200 }
  validates :content, presence: true
  validates :user_id, presence: true
  validates :post_id, presence: true

  belongs_to :user
  belongs_to :post
  has_rich_text :content
  has_many :replies, dependent: :destroy

  delegate :name, to: :user, prefix: true
end
