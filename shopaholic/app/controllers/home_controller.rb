class HomeController < ApplicationController

  def index
    #FIXME_AB: Any specific reason displaying only 9 records on home page. Shouldn't we add pagination
    @products = Product.all.order(:created_at).limit(9)
  end
end
