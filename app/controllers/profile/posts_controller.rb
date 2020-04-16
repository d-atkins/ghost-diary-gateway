class Profile::PostsController < Profile::BaseController

  def index
    @posts = current_user.posts
  end

  def show
    @post = current_user.posts.find(params[:id])
  end

end
