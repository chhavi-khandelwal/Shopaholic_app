class CategoriesController < ApplicationController
  before_action :set_category, only: [:show] 
  def show
    @products = @category.products
  end

  private
  def set_category
    @category = Category.find(params[:id])
    #FIXME_AB: What if record not found with the ID provided in the above line. Should handle this too.
  end
end
