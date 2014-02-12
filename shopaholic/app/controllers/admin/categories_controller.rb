#FIXME_AB: See comments added in brands controller
class Admin::CategoriesController < Admin::AdminsController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :category_not_found
  rescue_from ActiveRecord::DeleteRestrictionError, with: :cannot_destroy_category
  
  def index
    @categories = Category.page(params[:page]).per(3)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_category_path(@category), notice: 'Category was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @category.update(category_params)
      redirect_to admin_category_path(@category), notice: 'Category was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @category.destroy 
    redirect_to admin_categories_url, notice: 'Category destroyed successfully.'
  end

  private
  def set_category
      @category = Category.find(params[:id])
    end
  
  def cannot_destroy_category
    redirect_to admin_categories_path, notice: 'Category has products..It cannot be destroyed'
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def category_not_found
    redirect_to admin_categories_path, notice: 'Category doesnot exist'
  end
end
