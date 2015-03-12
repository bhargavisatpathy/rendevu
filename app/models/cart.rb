class Cart
  attr_accessor :cart_items

  def initialize(cart_items = [])
    @cart_items = cart_items || []
  end

  def empty?
    @cart_items.count == 0
  end

  def add_item(item_id)
    @cart_items << item_id
  end

  def count
    @cart_items.count
  end

  def remove_item(item_id)
    @cart_items.delete(item_id)
  end

  def clear
    @cart_items = []
  end

  def contains?(item_id)
    @cart_items.include?(item_id)
  end
end
