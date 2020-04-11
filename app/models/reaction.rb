class Reaction < ApplicationRecord
  validates_presence_of :category

  belongs_to :user
  belongs_to :post

  enum category: { like: 0, dislike: 1, can_relate: 2, lol: 3, upset: 4 }
end
