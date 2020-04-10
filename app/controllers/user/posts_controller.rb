class User::PostsController < User::BaseController

  def index
    @posts = Post.matching_group_and_user(current_user)
  end

  def show
    @post = Post.find(params[:id])
  end

end
