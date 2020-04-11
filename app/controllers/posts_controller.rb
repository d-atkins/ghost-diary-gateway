class PostsController < ApplicationController
  before_action :require_user

  def index
    @posts = Group.find(current_user.group.id).posts
  end

  def show
    @post = Post.find(params[:id])
  end

end
