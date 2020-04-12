class User < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :role
  validates :uid, uniqueness: true, presence: true

  has_many :posts
  has_many :reactions
  belongs_to :group, optional: true

  enum role: { admin: 0, registered_user: 1 }

  def post_count
    posts.count
  end
end
