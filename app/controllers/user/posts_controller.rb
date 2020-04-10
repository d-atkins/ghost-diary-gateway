class User::PostsController < User::BaseController

  def index
    @posts = Post.all.matching_group_and_user(current_user)
  end

end
