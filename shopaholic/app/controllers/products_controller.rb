class ProductsController < ApplicationController
  def show
    #FIXME_AB: What if record not found with the id provided. Handle such cases everywhere
    #fixed
    @product = Product.find_by(id: params[:id])
    @color = Color.published.find_by(id: params[:color_id])
    redirect_to root_path, alert: 'Product not found' if(@product.nil? || @color.nil?)
  end
end
