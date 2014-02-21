class CategoriesController < ApplicationController
  before_action :set_category, only: [:show] 
  def show
    @products = @category.products.published
  end

  private
  def set_category
    @category = Category.find_by(id: params[:id])
    redirect_to root, alert: 'Category not found' if @category.nil?
  end
end
