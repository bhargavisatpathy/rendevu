class CartItemsController < ApplicationController

  def create
    @cart.add_item(params[:item_id])
    session[:cart] = @cart.cart_items
    redirect_to request.referer
  end

  def destroy
    puts "this is destroy"
    @cart.remove_item(params[:item_id])
    redirect_to request.referer
  end
end
