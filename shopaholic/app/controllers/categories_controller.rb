class CategoriesController < ApplicationController
  before_action :set_category, only: [:show] 
  def show
    @products = @category.products.published
    # @products = @category.products.available_to_display.published
  end

  private
  def set_category
    @category = Category.find_by(id: params[:id])
    redirect_to root, alert: 'Category not found' if @category.nil?
    #FIXME_AB: What if record not found with the ID provided in the above line. Should handle this too.
  end
    #fixed
end
