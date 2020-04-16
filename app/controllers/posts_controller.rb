class PostsController < ApplicationController
  before_action :require_user

  def index
    @posts = day_today.posts.paginate(page: params[:page], per_page: 1)
  end

  def show
    @post = Post.find(params[:id])
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
      ToneService.get_tone_by_text(post_body)
    end

end
