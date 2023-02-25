class Post < ApplicationRecord
  validates :title, length: { minimum: 10, maximum: 200 }, presence: true
  validates :user_id, presence: true
  validates :content, presence: true
  enum status: {
    pending: 0,
    approved: 1,
    not_approved: 2
  }
  validates :status, inclusion: { in: statuses.keys }

  belongs_to :user

  has_rich_text :content
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :suggestions, dependent: :destroy
  has_many :reports, as: :reportable, dependent: :destroy

  scope :recent_post, -> { order(updated_at: :desc).limit(5) }
  scope :order_posts, -> { order(updated_at: :desc) }
  scope :pending_posts, -> { where(status: 'pending') }
  scope :approved_posts, -> { where(status: 'approved') }
  delegate :name, to: :user, prefix: true
end
