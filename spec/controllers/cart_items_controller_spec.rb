require 'rails_helper'


RSpec.describe CartItemsController, :type => :controller do

  describe "POST create" do

    it "can adds an item" do
      request.env["HTTP_REFERER"] = venues_path
      post :create, item_id: "123"

      expect(response).to redirect_to(venues_path)
    end
  end

  describe "DELETE destroy" do

    it "can delete an item" do
      request.env["HTTP_REFERER"] = venues_path
      post :create, item_id: "123"
      delete :destroy, item_id: "123"
      expect(response).to redirect_to(venues_path)
    end
  end
end
