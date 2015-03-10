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
    if path == "plans_path"
      redirect_to plans_path
    # elsif path == "plan"
    #   redirect_to seller_store_path(current_user.slug)
    # elsif path == "seller_dashboard"
    #   redirect_to seller_dashboard_path(current_user.slug)
    # else
    #   redirect_to path
    end
  end

  def send_sms(to_phone, message)
    client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
    message = client.messages.create from: '7206135838', to: to_phone, body: message#, status_callback: request.base_url + '/twilio/status'
    #render plain: message.status
  end

end
