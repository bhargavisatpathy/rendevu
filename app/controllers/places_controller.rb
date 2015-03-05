class PlacesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @places = Place.where(category_id: params[:id])
  end

end
