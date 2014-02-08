class Admin::DashboardsController < ApplicationController
  def show
    #FIXME_AB: Use pagination
    @products = Product.all
    @categories = Category.all
    @recent_products = @products.order('created_at DESC')
  end
end
