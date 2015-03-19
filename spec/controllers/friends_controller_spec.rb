require 'rails_helper'

RSpec.describe FriendsController, :type => :controller do

  before(:each) do
    allow_any_instance_of(TwilioMessenger)
      .to receive(:send_sms)
  end

  describe "GET index" do

    it "assigns friends" do
      mock_logged_in_user
      get :index
      expect(assigns(:friends).count).to eq(0)
    end

    it "renders the index template" do
      mock_logged_in_user
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET new" do

    it "assigns friends" do
      mock_logged_in_user
      get :new
      expect(assigns(:friend).present?).to be true
    end

    it "renders the new template" do
      mock_logged_in_user
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST create" do

    it "adds a friend" do
      mock_logged_in_user
      params = {friend: {name: 'Jiji', phone_number: '1234567892'}}
      post :create, params
      expect(response).to redirect_to(friends_path)
    end
  end

  describe "GET edit" do

    it "edit friends" do
      mock_logged_in_user
      friend = create(:friend)
      get :edit, id: friend.id
      expect(assigns(:friend).present?).to be true
    end

    it "renders the edit template" do
      mock_logged_in_user
      friend = create(:friend)
      get :edit, id: friend.id
      expect(response).to render_template(:edit)
    end
  end

  describe "PUT update" do

    it "can update friend" do
      mock_logged_in_user
      friend = create(:friend)
      params = {id: friend.id, friend: {name: 'Jiji', phone_number: '1234567892'}}
      put :update, params
      expect(response).to redirect_to(friends_path)
    end
  end

  describe "DELETE destroy" do

    it "can delete friend" do
      mock_logged_in_user
      friend = create(:friend)
      delete :destroy, id: friend.id
      expect(response).to redirect_to(friends_path)
    end
  end
  
  def mock_logged_in_user
    user = create(:user)
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(user)
  end

end
