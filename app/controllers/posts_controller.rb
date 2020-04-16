class PostsController < ApplicationController
  before_action :require_user

  def index
    @posts = day_today.posts.paginate(page: params[:page], per_page: 1)
  end

  def show
    @post = Post.find(params[:id])
  end

end
