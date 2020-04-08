class Post < ApplicationRecord
  validates_presence_of :body
  validates_presence_of :tone

  belongs_to :day
  belongs_to :user
end
