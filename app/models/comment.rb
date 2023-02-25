class Comment < ApplicationRecord
  validates :body, presence: true, length: { minimum: 2, maximum: 200 }
  validates :post_id, presence: true
  validates :user_id, presence: true

  belongs_to :post
  belongs_to :user
  belongs_to :parent, class_name: 'Comment', optional: true

  has_one_attached :image, dependent: :destroy

  has_many :comments, foreign_key: 'parent_id', dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :reports, as: :reportable, dependent: :destroy

  scope :order_by_id, -> { order(id: :desc) }
  scope :sort_comments, -> { where(parent_id: nil) }
  scope :recent_comments, -> { order(id: :desc).limit(5) }

  delegate :name, to: :user, prefix: true
end
