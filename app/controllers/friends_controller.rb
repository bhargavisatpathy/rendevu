class FriendsController < ApplicationController
  def index
    if current_user
      @friends = current_user.friends
    else
      session[:forward_to] = "friends_path"
      redirect_to signin_path
    end
  end

  def new
    @friend = Friend.new
  end

  def create
    @friend = Friend.new(friend_params)
    @friend.user = current_user
    if @friend.save
      TwilioMessenger.new(@friend.phone_number, "Hi #{@friend.name}, #{@friend.user.first_name} has added you as a friend in Rendevu").send_sms
      flash[:success] = "You've add a friend to you friend list"
      redirect_to friends_path
    else
      render :new
    end
  end

  def edit
    @friend = Friend.find(params[:id])
  end

  def update
    @friend = Friend.find(params[:id])
    @friend.update(friend_params)
    if @friend.save
      redirect_to friends_path
    else
      render :edit
    end
  end

  def destroy
    Friend.destroy(params[:id])
    redirect_to friends_path
  end

  private

  def friend_params
    params.require(:friend).permit(:name, :phone_number)
  end
end
