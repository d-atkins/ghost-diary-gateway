class User < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :email
  validates_presence_of :role

  has_secure_password
  
  belongs_to :group
end
