class InvitationsController < ApplicationController
  def index
    @invitations = current_user.invitations
  end

  def new
    if current_user
      @invitation = Invitation.new
    else
      session[:forward_to] = "new_invitation_path"
      redirect_to signin_path
    end
  end

  def create
    @invitation = Invitation.new(invitation_params)
    if @invitation.save
      flash[:success] = "You've created a new invitation"
      redirect_to invitations_path
    else
      redirect_to new_invitation_path
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:name)
  end
end
