class User < ApplicationRecord
  validates :email, presence: true
  validates :name, presence: true, length: { minimum: 10, maximum: 70 }
  validates :username, presence: true, length: { minimum: 5, maximum: 30 }
  validates :password, presence: true, length: { minimum: 6, maximum: 70 }
  enum role: { user: 0, moderator: 1, admin: 2 }
  validates :role, inclusion: { in: roles.keys }

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :suggestions, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_many :replies, dependent: :destroy

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable, :lockable
end
