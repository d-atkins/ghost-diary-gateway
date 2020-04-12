class Post < ApplicationRecord
  validates_presence_of :body
  validates_presence_of :tone

  belongs_to :day
  belongs_to :user

  validates_length_of :body, maximum: 222, allow_blank: true
end
