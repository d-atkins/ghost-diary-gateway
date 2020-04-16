class Admin::PostsController < ApplicationController
  def destroy
    Post.destroy(params[:id])
    redirect_to admin_dashboard_path
  end
end
