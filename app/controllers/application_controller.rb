class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorize!
    redirect_to root_path unless current_user
  end

  def set_cart
    @cart = Cart.new(session[:cart])
  end
  before_action :set_cart

  def redirect_after_login
    redirect_to session[:return_to]
    session[:return_to] = nil
  end

  def redirect_forward
    path = session[:forward_to]
    session[:forward_to] = nil
    if path == "plans_path"
      redirect_to plans_path
    elsif path == "friends_path"
      redirect_to friends_path
    end
  end
end
