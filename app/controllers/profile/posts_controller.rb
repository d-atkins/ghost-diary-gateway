class Profile::PostsController < Profile::BaseController

  def index
    @posts = current_user.posts
  end

  def show
    @post = current_user.posts.find(params[:id])
  end

  def create
    day = Day.create(week: 1, day_of_week: 1, group: current_user.group)
    tone = "empty"
    defaults = {day: day, tone: tone}
    params = defaults.merge(post_params)
    post = current_user.posts.new(params)
    post.save
    redirect_to posts_path
  end

  private
    def post_params
      params.permit(:body, :tone, :day)
    end

end
