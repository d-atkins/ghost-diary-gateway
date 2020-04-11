class Post < ApplicationRecord
  validates_presence_of :body
  validates_presence_of :tone

  has_many :reactions
  belongs_to :day
  belongs_to :user

  def reaction_by_user(user, category)
    reactions.find_by(user: user, category: category)
  end
end
