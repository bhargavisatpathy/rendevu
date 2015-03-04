class SessionsController < ApplicationController
  def new
  end

  def create
    user = facebook_user || rendevu_user

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
    session.clear
    flash[:success] = "Successfully logged out"
    redirect_to root_path
  end

  private

  def auth
    request.env['omniauth.auth']
  end

  def rendevu_user
    if params[:session]
      user = User.find_by(email: params[:session][:email])
      user && user.authenticate(params[:session][:password]) ? user : false
    end
  end

  def facebook_user
    if auth
      User.find_or_create_from_auth(auth)
    end
  end
end
