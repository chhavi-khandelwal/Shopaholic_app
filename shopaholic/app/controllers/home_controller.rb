class HomeController < ApplicationController

  before_action :get_products, only: [:get_products_data]
  
  def index
    @products = Product.all.order('created_at').limit(9)
  end

  def get_products_data
    respond_to do |format|
      format.json { render json: @products.to_json }
    end
  end

  private
  def get_products
    @category = Category.find(params[:id]) 
    @products = @category.products
    # @product_images = @category.products.map do |product|
    #   color = product.colors.first;
    #   if color
    #     color.images.first.file.url(:medium)
    #   end
    # end
  end
end
