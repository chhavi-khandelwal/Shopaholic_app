class HomeController < ApplicationController

  def index
    @products = Product.all.order(:created_at).limit(9)
  end
end
