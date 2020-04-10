class PostsController < ApplicationController

  def index
    @posts = Post.with_matching_group(current_user.group.id)
  end

  def show
    @post = Post.find(params[:id])
  end

end
