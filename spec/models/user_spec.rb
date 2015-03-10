require "rails_helper"

describe User, { type: "model" } do
  let(:user) { User.create(first_name: "Siya",
                           last_name: "Purohit",
                           email: "siya@email.com",
                           password: "password"
                           )}

  it "is valid" do
    expect(user).to be_valid
  end

  it "is invalid without a first name" do
    user.first_name = nil
    expect(user).not_to be_valid
  end

  it "is invalid without a last name" do
    user.last_name = nil
    expect(user).not_to be_valid
  end

  it "is invalid without an email" do
    user.email = nil
    expect(user).not_to be_valid
  end

  it "has a correctly formatted email address" do
    user.email = "bob.com"
    expect(user).not_to be_valid
  end

  it "has unqiue email address" do
    user
    new_user = User.create(first_name: "Arya", last_name: "Purohit",
                           email: "siya@email.com", password: "password")
    expect(new_user).not_to be_valid
  end

  it "can have one or more plans" do
    user
    plan1 = Plan.create(name: "Birthday Party", user_id: user.id)
    plan2 = Plan.create(name: "Pool Party", user_id: user.id)
    expect(user.plans.count).to eq(2)
    expect(user.plans[0].name).to eq("Birthday Party")
  end

  it "can have one or more friends" do
    user
    friend1 = Friend.create(name: "Nina", phone_number: "2223334444", user_id: user.id)
    friend2 = Friend.create(name: "Arya", phone_number: "1113335555", user_id: user.id)
    expect(user.friends.count).to eq(2)
    expect(user.friends[0].name).to eq("Nina")
  end
end
