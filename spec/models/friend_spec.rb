require 'rails_helper'

describe Friend, { type: "model" } do
  let(:friend) { Friend.create(name: "Siya Purohit", phone_number: "3035622251" )}

  it "is valid" do
    expect(friend).to be_valid
  end

  it "is invalid without a name" do
    friend.name = nil
    expect(friend).not_to be_valid
  end

  it "is invalid without a phone number" do
    friend.phone_number = nil
    expect(friend).not_to be_valid
  end

  it "is invalid without a 10 digit phone number" do
    friend.phone_number = "12345"
    expect(friend).not_to be_valid
    friend.phone_number = "1ASC3452F3"
    expect(friend).not_to be_valid
    friend.phone_number = "134253145325"
    expect(friend).not_to be_valid
  end

  it "is associated with a user" do
    user = User.create(first_name: "Aryaman",
                       last_name: "Purohit",
                       email: "arya@email.com",
                       password: "password"
                       )
    friend.user_id = user.id
    expect(friend.user.first_name).to eq("Aryaman")
  end

end
