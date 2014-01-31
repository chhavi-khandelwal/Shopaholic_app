class Admin::DashboardsController < ApplicationController
  def show
    #FIXME_AB: Use pagination
    @products = Product.all
    @categories = Category.all
  end
end
