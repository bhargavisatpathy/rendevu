class UsersController < ApplicationController
  def new
    if params[:forward_to]
      session[:forward_to] = params[:forward_to]
    else
      session[:return_to] ||= request.referer
    end
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "You have successfully created your account. Welcome #{@user.first_name}"
      session[:forward_to] ? redirect_forward : redirect_after_login
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end
