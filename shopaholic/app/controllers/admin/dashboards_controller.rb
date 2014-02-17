#FIXME_AB: Why Dashboards?
class Admin::DashboardsController < Admin::AdminsController
  def show
    #FIXME_AB: Need to think, if we need to display all the products and category on dashboard
    @products = Product.all
    @categories = Category.all
    @recent_products = @products.order(created_at: :desc)
  end
end
