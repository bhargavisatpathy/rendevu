class FriendsController < ApplicationController
  def index
    @friends = Friend.all
  end

  def new
    @friend = Friend.new
  end

  def create
    @friend = Friend.new(friend_params)
    @friend.user = current_user
    if @friend.save
      send_sms(@friend.phone_number, "Hi #{@friend.name}, #{@friend.user.first_name} has added you as a friend in Rendevu")
      flash[:success] = "You've add a friend to you friend list"
      redirect_to friends_path
    else
      redirect_to new_friend_path
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
      flash[:errors] = @friend.errors.full_messages.uniq.join("<br>")
      redirect_to edit_friend_path
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
