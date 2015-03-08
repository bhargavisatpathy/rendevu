require "rails_helper"

describe Place, { type: "model" } do
  let(:category) { Category.create(name: "Restaurant", description: "Eat and Dine")}
  let(:place) { Place.create(name: "Qdoba", address: "Parker, CO", category_id: category.id)}

  it "is valid" do
    expect(place).to be_valid
  end

  it "is not valid without a name" do
    place.name = nil
    expect(place).to_not be_valid
  end

  it "is not valid without an address" do
    place.address = nil
    expect(place).to_not be_valid
  end

  it "is associated with a category" do
    expect(place.category.name).to eq("Restaurant")
  end
end
