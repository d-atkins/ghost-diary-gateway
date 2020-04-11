class Group < ApplicationRecord
  validates_presence_of :name
  has_many :users
  has_many :days
  has_many :posts, through: :days
end
