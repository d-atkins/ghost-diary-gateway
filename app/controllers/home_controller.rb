class HomeController < ApplicationController
  def index
    redirect_to posts_path if user_belongs
  end
end
