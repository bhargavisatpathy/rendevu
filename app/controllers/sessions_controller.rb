class SessionsController < ApplicationController
  def new
  end

  def new_account
  end

  def create
    user = User.find_or_create_from_auth(auth)
    if user
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      redirect_to root_path
    end
  end

  def destroy
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
