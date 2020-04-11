class ReactionsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    Reaction.create(type: params[:type], user: current_user, post: post)
    redirect_back fallback_location: post_path(post)
  end
end
