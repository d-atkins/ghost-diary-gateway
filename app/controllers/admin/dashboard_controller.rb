class Admin::DashboardController < ApplicationController

  def index
    @posts = Post.all
  end
end
