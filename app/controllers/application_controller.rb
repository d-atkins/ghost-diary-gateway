class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :category_to_string, :number_to_word

  def category_to_string(category)
    ['Like', 'Dislike', 'Can relate', 'Lol', 'Upset'][category]
  end

  def number_to_word(number)
    return number if number > 10
    ['no one',
      'one',
      'two',
      'three',
      'four',
      'five',
      'six',
      'seven',
      'eight',
      'nine',
      'ten'][number]
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
    render file: "/public/404" unless current_user
  end
end
