class Day < ApplicationRecord
  validates_presence_of :week
  validates_presence_of :day_of_week
  belongs_to :group
  has_many :posts
  enum day_of_week: { Sunday: 0, Monday: 1, Tuesday: 2, Wednesday: 3, Thursday: 4, Friday: 5, Saturday: 6 }
end
