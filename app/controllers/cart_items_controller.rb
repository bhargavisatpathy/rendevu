class CartItemsController < ApplicationController

  def create
    @cart.add_item(params[:item_id])
    session[:cart] = @cart.cart_items
    redirect_to :back
  end

  def destroy
    @cart.remove_item(params[:item_id])
    redirect_to :back
  end
end
