class ReactionsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    post.add_reaction(current_user, params[:category].to_i)
    back_to_post(post)
  end

  def destroy
    Reaction.destroy(params[:id])
    back_to_post(params[:post_id])
    rescue ActiveRecord::RecordNotFound
      back_to_post(params[:post_id])
  end

  private
    def back_to_post(post)
      redirect_back fallback_location: post_path(post)
    end
end
