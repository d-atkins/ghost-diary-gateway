class Day < ApplicationRecord
  validates_presence_of :week
  validates_presence_of :day_of_week
  belongs_to :group
  # has_many :day_posts
  # has_many :posts, through: :day_posts
  enum week: { one: 0, two: 1, three: 2, four: 3, five: 4, six: 5 }
  enum day_of_week: { monday: 0, tuesday: 1, wednesday: 2, thursday: 3, friday: 4 }
end
