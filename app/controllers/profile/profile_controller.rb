class ProfileController  < Profile::BaseController

  def show
    get_user if current_user
    failure_message if !current_user
  end


  private

  def get_user
    @user = current_user
    flash[:success] = "#{@user.name} is logged in."
  end

  def failure_message
    flash[:failure] = "You must login to view your profile's information."
    redirect_to '/'
  end

end
