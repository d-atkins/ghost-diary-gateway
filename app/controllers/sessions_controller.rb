class SessionsController < ApplicationController
  def create
    user_info = request.env['omniauth.auth']
    uid = user_info[:uid]
    name = user_info[:info][:nickname]

    user = User.find_by(uid: [uid])
    if user.nil?
      user = User.create(uid: uid, name: name)
    end
    session[:user_id] = user.id

    redirect_to '/'
  end

  def destroy
    session.delete(:user_id)
    flash[:success] = 'You have logged out.'
    redirect_to '/'
  end
end
