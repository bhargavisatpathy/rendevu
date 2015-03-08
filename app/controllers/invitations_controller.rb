class InvitationsController < ApplicationController
  before_action :authorize!, only: [:new, :create]
  def index
    if current_user
      @invitations = current_user.invitations
    else
      session[:forward_to] = "invitations_path"
      redirect_to signin_path
    end
  end

  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(invitation_params)
    @invitation.user = current_user
    if @invitation.save
      flash[:success] = "You've created a new invitation"
      redirect_to invitations_path
    else
      redirect_to new_invitation_path
    end
  end

  def edit
    @invitation = Invitation.find(params[:id])
  end

  def update
    @invitation = Invitation.find(params[:id])
    @invitation.update(invitation_params)
    if @invitation.save
      redirect_to invitations_path
    else
      flash[:errors] = @invitation.errors.full_messages.uniq.join("<br>")
      redirect_to edit_invitation_path
    end
  end

  def destroy
    Invitation.destroy(params[:id])
    redirect_to invitations_path
  end

  private

  def invitation_params
    params.require(:invitation).permit(:name)
  end
end
