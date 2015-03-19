require 'rails_helper'

RSpec.describe PlansController, :type => :controller do
  before(:each) do
    allow_any_instance_of(TwilioMessenger)
      .to receive(:send_sms)
  end

  describe "GET index" do

    it "assigns friends" do
      mock_logged_in_user
      get :index
      expect(assigns(:plans).count).to eq(0)
    end

    it "renders the index template" do
      mock_logged_in_user
      get :index
      expect(response).to render_template(:index)
    end
  end

  def mock_logged_in_user
    user = create(:user)
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(user)
  end


end
