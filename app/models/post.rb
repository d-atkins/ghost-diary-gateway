class Post < ApplicationRecord
  validates_presence_of :body
  validates_presence_of :tone

  belongs_to :day
  belongs_to :user

  def self.with_matching_group(user_group_id)
    all_posts = joins(:day).select('posts.*, days.group_id as group')
    all_posts.find_all {|post| post.group == user_group_id}
  end

  def self.matching_group_and_user(user)
    all_posts = joins(:day).select('posts.*, days.group_id as group')
    all_posts.find_all {|post| post.group == user.group.id && post.user.id == user.id}
  end

end
