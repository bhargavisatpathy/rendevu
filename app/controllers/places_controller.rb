class PlacesController < ApplicationController
  def index
    @categories = Category.all
  end

end
