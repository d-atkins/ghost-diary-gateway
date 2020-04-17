class PostsController < ApplicationController
  before_action :require_group

  def index
    @post = day_today.posts.sample
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    if post_body[:body].length > 222
      flash[:errors] = 'Body is too long (maximum is 222 characters)'
    elsif post_body[:body].length <= 0
      flash[:errors] = "Body can't be blank"
    else
      PostMakerJob.perform_later(post_body[:body], current_user.id, day_today.id)
    end
    redirect_to posts_path
  end

  private

    def post_body
      params.permit(:body)
    end

    def require_group
      render file: "/public/404" unless current_user && current_user.group
    end

end
