require 'rails_helper'

RSpec.describe Invitation, :type => :model do
  let(:friend) {Friend.create(name:"Arya", phone_number:"1234563789")}

  let(:plan) { plan = Plan.new(name: "Birthday Party",
                        time: "2016-03-10 22:30:29")
                   .init(create(:user), [friend.id], ['Venue1', 'Venue2'])
               plan.save
               plan
             }
  it "is associated with a plan" do
    invitation = create(:invitation)
    invitation.plan_id = plan.id
    expect(invitation.plan.name).to eq("Birthday Party")
  end

  it "is associated with a friend" do
    invitation = create(:invitation)
    invitation.friend_id = friend.id
    expect(invitation.friend.name).to eq("Arya")
  end

end
