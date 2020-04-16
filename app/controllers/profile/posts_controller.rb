class Profile::PostsController < Profile::BaseController

  def index
    @posts = current_user.posts.paginate(page: params[:page], per_page: 10)
  end

  def show
    @post = current_user.posts.find(params[:id])
  end

end
