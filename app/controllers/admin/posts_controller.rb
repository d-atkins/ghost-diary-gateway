class Admin::PostsController < Admin::BaseController
  def index
    @posts = Post.all.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
  end

  def destroy
    Post.destroy(params[:id])
    redirect_to admin_posts_path
  end
end
