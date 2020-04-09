class User < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :role
  validates :uid, uniqueness: true, presence: true

  has_many :posts

  belongs_to :group

  enum role: { admin: 0, registered_user: 1 }

  def post_count 
    posts.count
  end
end
