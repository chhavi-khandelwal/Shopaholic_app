class HomeController < ApplicationController

  before_action :get_products, only: [:get_products_data]
  
  def index
    @products = Product.all.order(:created_at).limit(9)
  end

  
end
