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

  def create
    @plan = Plan.new(plan_params)

    @plan.add_friends(params[:plan][:friends])
    @plan.add_venues(params[:plan][:venues])
    @plan.add_time(DateTime.new(params[:option]["time(1i)"].to_i,
      params[:option]["time(2i)"].to_i,params[:option]["time(3i)"].to_i,
      params[:option]["time(4i)"].to_i, params[:option]["time(5i)"].to_i))
    if @plan.time.nil?
      flash[:errors] = "Please select a future date!"
    end
    @plan.user = current_user

    if @plan.save
      notify_friends
      redirect_to plans_path
    else
      @venues = @cart.cart_items.map { |id| Venue.find(id) }
      render :new
    end
  end

  def edit
    @plan = Plan.find(params[:id])
  end

  def update
    @plan = Plan.find(params[:id])
    @plan.update(plan_params)

    if @plan.save
      redirect_to plans_path
    else
      render :edit
    end
  end

  def destroy
    Plan.destroy(params[:id])
    redirect_to plans_path
  end

  private

  def plan_params
    params.require(:plan).permit(:name)
  end

  def notify_friends
    @plan.invitations.each do |invitation|
      invitation.voting_token = SecureRandom.urlsafe_base64
      invitation.save
      TwilioMessenger.new(invitation.friend.phone_number, "You are invited to vote on #{@plan.name} #{vote_url(token: invitation.voting_token)}").send_sms
    end
  end

end
