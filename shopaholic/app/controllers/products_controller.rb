class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])
    @color = Color.find(params[:color_id])
  end
end
