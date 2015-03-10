require 'rails_helper'

RSpec.describe Plan, :type => :model do
  let(:plan) { Plan.create(name: "Birthday Party")}

  it "is valid" do
    expect(plan).to be_valid
  end

  it "is invalid without a name" do
    plan.name = nil
    expect(plan).not_to be_valid
  end

  it "has status open by default" do
    plan
    expect(plan.status).to eq("open")
  end

  it "is associated with a user" do
    user = User.create(first_name: "Aryaman",
                       last_name: "Purohit",
                       email: "arya@email.com",
                       password: "password"
                       )
    plan.user_id = user.id
    expect(plan.user.first_name).to eq("Aryaman")
  end
end
