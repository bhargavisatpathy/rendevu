require 'rails_helper'

RSpec.describe Plan, :type => :model do
  let(:friend) {Friend.create(name:"Arya", phone_number:"1234563789")}

  let(:plan) { plan = Plan.new(name: "Birthday Party",
                        time: "2016-03-10 22:30:29")
                   .init(create(:user), [friend.id], ['Venue1', 'Venue2'])
               plan.save
               plan
             }

  it "is valid" do
    expect(plan).to be_valid
  end

  it "is invalid without a name" do
    plan.name = nil
    expect(plan).not_to be_valid
  end

  it "is invalid without a user" do
    plan.user = nil
    expect(plan).not_to be_valid
  end

  it "is invalid without a friend" do
    plan.friends = []
    expect(plan).not_to be_valid
  end

  it "is invalid without an option" do
    plan.options = []
    expect(plan).not_to be_valid
  end

  it "is invalid with one option" do
    plan.options = []
    plan.add_venues(["venue1"])
    expect(plan).not_to be_valid
  end

  it "is invalid with more than three options" do
    plan.options = []
    plan.add_venues(["venue1", "venue2", "venue3", "venue4"])
    expect(plan).not_to be_valid
  end

  it "has status open by default" do
    plan
    expect(plan.status).to eq("open")
  end

  it "invalid without future time" do
    plan.time = nil
    expect(plan).not_to be_valid
  end

  it "validates future time" do
    expect(plan.errors.count).to eq(0)
    plan.time = "2014-03-10 22:30:29"
    plan.future_time
    expect(plan).not_to be_valid
    expect(plan.errors.count).to eq(1)
  end

  it "can add friends" do
    expect(plan.friends.count).to eq(1)
    friend2 = create(:friend)
    plan.add_friends([friend2.id])
    expect(plan.friends.count).to eq(2)
  end

  it "can add venues" do
    expect(plan.options.count).to eq(2)
    plan.add_venues(["venue"])
    expect(plan.options.count).to eq(3)
  end

end
