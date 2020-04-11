class ReactionsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    Reaction.create(category: params[:category].to_i, user: current_user, post: post)
    redirect_back fallback_location: post_path(post)
  end
end
