class SessionsController < ApplicationController
  def new
  end

  def new_account
  end

  def create
    user = User.find_or_create_from_auth(auth)
    if user
      session[:user_id] = user.id
      flash[:success] = "Welcome #{user.first_name}"
      redirect_to think_path
    else
      flash[:errors] = "You are not logged in"
      redirect_to root_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_to root_path
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
