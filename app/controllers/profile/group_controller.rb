class Profile::GroupController < ApplicationController
  def new
    @groups = Group.all
  end
end
