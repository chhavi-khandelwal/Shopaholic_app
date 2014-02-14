class Admin::DashboardsController < Admin::AdminsController
  def show
    @products = Product.all
    @categories = Category.all
    @recent_products = @products.order(created_at: :desc)
  end
end
