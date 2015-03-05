class Seed
  attr_accessor :categories
  def initialize
    p "=============================="
    p "Seeding started"
    p "=============================="
    generate_categories
    generate_places
    p "=============================="
    p "Seed data loaded"
    p "=============================="
  end

  def generate_categories
    @categories = Category.create([
      { name: "Restaurants", description: "Eat and dine" },
      { name: "Parks", description: "Relax and hangout" },
      { name: "Events", description: "Entertainment and fun" },
      { name: "Custom Made", description: "Make you own place to hangout" }
    ])
  end

  def generate_places
    @places = Place.create([
      { name: "India's Kitchen", address: "Parker, CO", category_id: categories[0].id},
      { name: "Chipotle", address: "Parker, CO", category_id: categories[0].id},
      { name: "Egg and I", address: "Parker, CO", category_id: categories[0].id},
      { name: "Salisbury Park", address: "Parker, CO", category_id: categories[1].id},
      { name: "Belly dance show", address: "Denver, CO", category_id: categories[2].id},
      { name: "Big Hero 6", address: "Parker, CO", category_id: categories[2].id}
    ])
  end
end

Seed.new
