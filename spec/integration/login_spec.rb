require "spec_helper"

describe "user authorization", type: :feature do
  include Capybara::DSL

  describe "user Signin" do
    it "allows a user to log" do
      create(:user)

      visit root_url
      click_link("Sign in")
      fill_in "session[email]", with: "siya@email.com"
      fill_in "session[password]", with: "password"
      click_button("Log in")
      expect(page).to have_content("Rendevu")
    end

    it "allows user to log in and not see invalid login" do
      create(:user)

      visit root_url
      click_link("Sign in")
      fill_in "session[email]", with: "siya@email.com"
      fill_in "session[password]", with: "password"
      click_button("Log in")
      expect(page).not_to have_content("Invalid Login")
    end
  end

  describe "Visitor(not logged user) actions" do
    it "can see the venues" do
      visit root_url
      click_link "Venues"
      expect(page).to have_content("Venues")
    end

    it "gets redirected to sign in page with tries to visit plan page" do
      visit root_url
      current_user = nil
      within("#sidebar-wrapper") do
        click_link("Plan")
      end
      expect(current_path).to eq("/signin")
    end

    it "gets redirected to sign in page with tries to visit friends page" do
      visit root_url
      current_user = nil
      within("#sidebar-wrapper") do
        click_link("Friends")
      end
      expect(current_path).to eq("/signin")
    end
  end
end
