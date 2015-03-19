require 'rails_helper'

describe Cart, { type: "model" } do

  it "has no items by default" do
    cart = Cart.new(nil)
    expect(cart.count).to eq(0)
  end

  it "can add an item to cart" do
    cart = Cart.new(nil)
    cart.add_item('123')
    expect(cart.count).to eq(1)
  end

  it "can remover an item from cart" do
    cart = Cart.new(nil)
    cart.add_item('123')
    expect(cart.count).to eq(1)
    cart.remove_item('123')
    expect(cart.count).to eq(0)
  end

  it "can clear a cart" do
    cart = Cart.new(nil)
    cart.add_item('123')
    expect(cart.count).to eq(1)
    cart.clear
    expect(cart.count).to eq(0)
  end

  it "can check content of cart" do
    cart = Cart.new(nil)
    cart.add_item('123')
    cart.add_item('124')
    cart.add_item('125')
    expect(cart.count).to eq(3)
    expect(cart.contains?('123')).to be true
  end
end
