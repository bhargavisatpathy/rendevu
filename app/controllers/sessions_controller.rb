class SessionsController < ApplicationController
  def new
  end

  def new_account
  end

  def create
    user = find_and_authenticate_user

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

  def find_and_authenticate_user
    User.find_by(email: params[:session][:email]).authenticate(params[:session][:password]) || User.find_or_create_from_auth(auth)
  end
end
