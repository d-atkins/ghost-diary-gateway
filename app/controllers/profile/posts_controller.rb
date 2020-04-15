class Profile::PostsController < Profile::BaseController

  def index
    @posts = current_user.posts
  end

  def show
    @post = current_user.posts.find(params[:id])
  end

  def create
    post = Post.new(post_params)
    if post.save
      flash[:success] = 'You have made a post!'
    else
      flash[:errors] = post.errors.full_messages.to_sentence
    end
    redirect_to posts_path
  end

  private
    def post_body
      params.permit(:body)
    end

    def post_params
      {day: day_today, tone: get_tone, user: current_user}.merge(post_body)
    end

    def get_tone
      tone_facade = ToneFacade.new(post_body[:body])
      tone_facade.assign_tone
    end

end
