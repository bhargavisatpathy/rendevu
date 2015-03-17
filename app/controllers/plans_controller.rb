class PlansController < ApplicationController
  before_action :authorize!, only: [:new, :create]
  def index
    if current_user
      @plans = current_user.plans
    else
      session[:forward_to] = "plans_path"
      redirect_to signin_path
    end
  end

  def new
    @plan = Plan.new
    @venues = @cart.cart_items.map { |id| Venue.find(id) }
  end

  def edit
    @plan = Plan.find(params[:id])
  end

  def create
    @plan = Plan.new(plan_params)
                .init(current_user,
                    params[:plan][:friends],
                    params[:plan][:venues])

    if @plan.save
      notify_friends
      redirect_to plans_path
    else
      @venues = @cart.cart_items.map { |id| Venue.find(id) }
      render :new
    end
  end

  def destroy
    Plan.destroy(params[:id])
    redirect_to plans_path
  end

  def update
    @plan = Plan.find(params[:id])
    @plan.options.find(params[:option].to_i).selected = true
    @plan.status = "finalized"
    if @plan.save
      invite_friends
      flash[:notice] = "Final invitation was sent to your friends!"
      redirect_to plans_path
    else
      render :edit
    end
  end

  private

  def plan_params
    params.require(:plan).permit(:name, :time)
  end

  def notify_friends
    @plan.invitations.each do |invitation|
      invitation.voting_token = SecureRandom.urlsafe_base64
      invitation.save
      TwilioMessenger.new(invitation.friend.phone_number, "You are invited to vote on #{@plan.name} #{vote_url(token: invitation.voting_token)}").send_sms
    end
  end

  def invite_friends
    @plan.friends.each do |friend|
      TwilioMessenger.new(friend.phone_number, "You are invited to hangout for #{@plan.name} at #{@plan.selected_venue.name} on #{@plan.time}").send_sms
    end
  end
end
