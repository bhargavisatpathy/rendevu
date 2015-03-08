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
end
