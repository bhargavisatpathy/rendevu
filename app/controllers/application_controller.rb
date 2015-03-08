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

  def redirect_after_login
    redirect_to session[:return_to]
    session[:return_to] = nil
  end

  def redirect_forward
    path = session[:forward_to]
    session[:forward_to] = nil
    if path == "new_invitation_path"
      redirect_to new_invitation_path
    # elsif path == "invitaion"
    #   redirect_to seller_store_path(current_user.slug)
    # elsif path == "seller_dashboard"
    #   redirect_to seller_dashboard_path(current_user.slug)
    # else
    #   redirect_to path
    end
  end

end
