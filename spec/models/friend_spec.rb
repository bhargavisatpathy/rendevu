require 'rails_helper'

describe Friend, { type: "model" } do

  it "is valid" do
    friend = create(:friend)
    expect(friend).to be_valid
  end

  it "is invalid without a name" do
    friend = build(:friend, name: nil)
    expect(friend).not_to be_valid
  end

  it "is invalid without a phone number" do
    friend = build(:friend, phone_number: nil)
    expect(friend).not_to be_valid
  end

  it "is invalid without a 10 digit phone number" do
    friend = create(:friend)
    friend.phone_number = "12345"
    expect(friend).not_to be_valid
    friend.phone_number = "1ASC3452F3"
    expect(friend).not_to be_valid
    friend.phone_number = "134253145325"
    expect(friend).not_to be_valid
  end

  it "is associated with a user" do
    user = create(:user)
    friend = create(:friend)
    friend.user_id = user.id
    expect(friend.user.first_name).to eq("Siya")
  end

end
