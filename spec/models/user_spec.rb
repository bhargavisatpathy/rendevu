require "rails_helper"

describe User, { type: "model" } do

  it "is valid" do
    user = create(:user)
    expect(user).to be_valid
  end

  it "is invalid without a first name" do
    user = create(:user)

    user.first_name = nil
    expect(user).not_to be_valid
  end

  it "is invalid without a last name" do
    user = create(:user)

    user.last_name = nil
    expect(user).not_to be_valid
  end

  it "is invalid without an email" do
    user = create(:user)

    user.email = nil
    expect(user).not_to be_valid
  end

  it "has a correctly formatted email address" do
    user = create(:user)

    user.email = "bob.com"
    expect(user).not_to be_valid
  end

  it "has unqiue email address" do
    user = create(:user)

    new_user = build(:user)
    expect(new_user).not_to be_valid
  end

  it "can have one or more plans" do
    user = create(:user)
    friend = create(:friend)

    expect(user.plans.count).to eq(0)
    plan1 = Plan.new(name: "Birthday Party", time: "2016-03-10 22:30:29")
                .init(user, [friend.id], ['Venue1', 'Venue2'])
    plan1.save
    plan2 = Plan.new(name: "Party", time: "2016-04-10 22:30:29")
                .init(user, [friend.id], ['Venue1', 'Venue2'])
    plan2.save
    expect(user.plans.count).to eq(2)
    expect(user.plans[0].name).to eq("Birthday Party")
  end

  it "can have one or more friends" do
    user = create(:user)

    friend1 = create(:friend, user_id: user.id)
    friend2 = create(:friend, name: "Nina", user_id: user.id)
    expect(user.friends.count).to eq(2)
    expect(user.friends[1].name).to eq("Nina")
  end
end
