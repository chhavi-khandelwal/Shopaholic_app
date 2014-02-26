class HomeController < ApplicationController

  def index
    #FIXME_AB: Any specific reason displaying only 9 records on home page. Shouldn't we add pagination
    @products = Product.published.order(:created_at).page(params[:page]).per(9)
    #fixed
    # @products = Product.available_to_display.order(:created_at).limit(9)
  end
end
