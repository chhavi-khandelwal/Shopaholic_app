class Admin::DashboardsController < ApplicationController
  def show
    @products = Product.all
    @categories = Category.all
  end
end
