class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  def calendar_week
    calendar_facade = CalendarFacade.new
    calendar_facade.week_of(user_group.calendar_id)
  end

  def user_group
    Group.find(current_user.group.id)
  end

  def day_today
    user_group.days.find_or_create_by(week: calendar_week, day_of_week: Time.now.wday)
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
    render file: "/public/404" unless current_user
  end

  def user_belongs
    current_user && current_user.group
  end
end
