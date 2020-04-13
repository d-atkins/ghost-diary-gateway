class Profile::PostsController < Profile::BaseController

  def index
    @posts = current_user.posts
  end

  def show
    @post = current_user.posts.find(params[:id])
  end

  def create
    length = post_params[:body].length
    create_post_process(length)
  end

  private
    def post_params
      params.permit(:body, :tone, :day)
    end

    def create_post_process(length)
      current_user.posts.create(get_params) if length <= 222
      display_message(length)
      redirect_to posts_path
    end

    def display_message(length)
      flash[:failure] = "Your post cannot exceed 222 characters. Your post was #{length} characters." if length > 222
      flash[:empty] = "Your post cannot be empty." if params[:body] == ""
    end

    def get_params
      day = Day.find_or_create_by(week: 1, day_of_week: 1, group: current_user.group)
      params = {day: day, tone: get_tone}.merge(post_params)
    end

    def get_tone
      tone_facade = ToneFacade.new(post_params[:body])
      tone_facade.assign_tone
    end

end
