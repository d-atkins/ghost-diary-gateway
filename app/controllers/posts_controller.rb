class PostsController < ApplicationController

  def index
    @posts = Post.all.with_matching_group(current_user.group.id)
  end

  def show
    @post = Post.find(params[:id])
  end

end
