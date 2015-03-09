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
  end

  def create
    @plan = Plan.new(plan_params)
    @plan.user = current_user
    if @plan.save
      notify(@plan.name)
      flash[:success] = "You've created a new plan"
      redirect_to plans_path
    else
      redirect_to new_plan_path
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
      flash[:errors] = @plan.errors.full_messages.uniq.join("<br>")
      redirect_to edit_plan_path
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

  def notify(name)
    client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
    message = client.messages.create from: '7206135838', to: '7205300432', body: "You are invited to join #{name}"#, status_callback: request.base_url + '/twilio/status'
    #render plain: message.status
  end
end
