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
    @places = Place.where(id: @cart.cart_items)
  end

  def create
    @plan = Plan.new(plan_params)
    @plan.add_friends(params[:plan][:friends])
    @plan.user = current_user
    if @plan.save
      notify_friends
      redirect_to plans_path
    else
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
      TwilioMessenger.new(invitation.friend.phone_number, "You are invited to vote on #{@plan.name}").send_sms
    end
  end

end
