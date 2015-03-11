require "spec_helper"

describe "Static Pages", type: :feature do

  describe "Home page" do

    it "can be viewed by any visitor" do
      visit root_path
      expect(page).to have_link("How it works?")
    end
  end
end
