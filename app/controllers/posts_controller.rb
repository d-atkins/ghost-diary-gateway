class PostsController < ApplicationController
  before_action :require_user

  def index
    @posts = user_group.posts
  end

  def show
    @post = Post.find(params[:id])
  end

end
