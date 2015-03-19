require "spec_helper"

describe "Logged in user", type: :feature do
  include Capybara::DSL


  before(:each) do
    allow_any_instance_of(TwilioMessenger)
      .to receive(:send_sms)
  end

  it "can visit it's plan page" do
    mock_user
    visit root_url
    within("#sidebar-wrapper") do
      click_link("Plan")
    end
    expect(page).to have_link("Create Plan")
  end

  it "can create a plan" do
    mock_user
    visit root_url
    click_link_or_button 'Friends'
    add_a_friend 'Jiji'
    click_link_or_button 'Venues'
    click_link("Plan")

    expect(page).to have_link("Create Plan")
    click_link_or_button("Create Plan")
    expect(page).to have_button("Submit")
    fill_in "plan[name]", with: "Fun"
    select 'Jiji', from: "plan_friends"
    expect(page).to have_link('Explore Venues')

  end

  it "can visit it's friends page" do
    mock_user
    visit root_url
    within("#sidebar-wrapper") do
      click_link("Friends")
    end
    expect(page).to have_link("Add Friends")
  end

  it "can add a friend" do
    mock_user
    visit root_url
    within("#sidebar-wrapper") do
      click_link("Friends")
    end
    expect(page).to have_link("Add Friends")
    add_a_friend("Jiji")
    expect(page).to have_content("Jiji")

  end

  private

  def mock_user
    user = create(:user)
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(user)
  end

  def add_a_friend(name)
    click_link_or_button("Add Friends")
    fill_in "friend[name]", with: name
    fill_in "friend[phone_number]", with: "7205300432"
    click_link_or_button("Submit")
  end
end
