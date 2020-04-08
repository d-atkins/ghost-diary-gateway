class Day < ApplicationRecord
  validates_presence_of :week
  validates_presence_of :day_of_week
  belongs_to :group
  # has_many :day_posts
  # has_many :posts, through: :day_posts
  enum day_of_week: { Monday: 0, Tuesday: 1, Wednesday: 2, Thursday: 3, Friday: 4 }
end
