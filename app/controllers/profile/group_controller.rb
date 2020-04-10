class Profile::GroupController < ApplicationController
  def new
    @groups = Group.all
  end

  def create
    group_id = group_params[:group_select]
    group = Group.find_by(id: group_id)
    if group
      current_user.update(group_id: group_id)
      flash[:sucess] = "You have joined #{group.name}!"
    end
    redirect_to posts_path
  end

  private
    def group_params
      params.permit(:group_select)
    end
end
