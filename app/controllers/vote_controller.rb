class VoteController < ApplicationController
  def edit
    @invitation = Invitation.find_by(voting_token: params[:token])
  end

  def update
    @invitation = Invitation.find_by(voting_token: params[:token])
    @invitation.voted = true
    @invitation.save
    @invitation.plan.options.where(id: params[:option].to_i).find_each do |option|
      option.rank += 1
      option.save
    end
    render :edit
  end
end
