class Admin::DashboardsController < Admin::AdminsController
  def show
    #FIXME_AB: Use pagination
    @products = Product.all
    @categories = Category.all
    #FIXME_AB: instead of 'created_at Desc' use created_at: :desc. Hash syntax
    @recent_products = @products.order(created_at: :desc)
    #fixed
  end
end
