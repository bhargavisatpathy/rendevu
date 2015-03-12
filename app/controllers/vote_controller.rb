class VoteController < ApplicationController
  def edit
    @invitation = Invitation.find_by(voting_token: params[:token])
  end

  def update
    @invitation = Invitation.find_by(voting_token: params[:token])
    @invitation.voted = true
    @invitation.save
    @invitation.plan.options.each do |option|
      if option.id.to_s == params[:option]
        option.rank += 1
        option.save
        break
      end
    end
    render :edit
  end
end
