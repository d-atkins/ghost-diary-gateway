class Profile::PostsController < Profile::BaseController

  def index
    @posts = current_user.posts
  end

  def show
    @post = current_user.posts.find(params[:id])
  end

  def create
    post = current_user.posts.new(post_params)
    post.save
    redirect_to profile_posts_path
  end

  private
    def post_params
      params.permit(:body, :tone, :day_id)
    end

end
