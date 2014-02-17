class ProductsController < ApplicationController
  def show
    #FIXME_AB: What if record not found with the id provided. Handle such cases everywhere
    @product = Product.find(params[:id])
    @color = Color.find(params[:color_id])
  end
end
