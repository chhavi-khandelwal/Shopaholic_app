#FIXME_AB: See comments added in brands controller
class Admin::CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  rescue_from ActiveRecord::DeleteRestrictionError, with: :cannot_destroy_category
  
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to admin_category_path(@category), notice: 'Category was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to admin_category_path(@category), notice: 'Category was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    respond_to do |format|
      @category.destroy 
      format.html { redirect_to admin_categories_url, notice: 'Category destroyed successfully.' }
    end
  end

  private
  def set_category
      @category = Category.find(params[:id])
    end
  
  def cannot_destroy_category
    respond_to do |format|
      format.html { redirect_to admin_categories_path, notice: 'Category has products..It cannot be destroyed' }
    end
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
