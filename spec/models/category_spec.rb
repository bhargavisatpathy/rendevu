require "rails_helper"

describe Category, { type: "model" } do
  let(:category) { Category.create(name: "Restaurant",
                           description: "Eat and Dine"
                           )}

  it "is valid" do
    expect(category).to be_valid
  end

  it "is not valid without a name" do
    category.name = nil
    expect(category).to_not be_valid
  end

  it "is associated with many places" do
    category
    place1 = Place.create(name: "Qdoba", address: "Denver, CO", category_id: category.id)
    place2 = Place.create(name: "Chipotle", address: "Parker, CO", category_id: category.id)
    expect(category.places.count).to equal 2
  end
end
