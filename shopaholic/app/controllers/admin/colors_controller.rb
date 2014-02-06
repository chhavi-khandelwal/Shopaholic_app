class Admin::ColorsController < ApplicationController
  before_action :set_color, only: [:update, :destroy, :edit, :cannot_destroy_color]
  rescue_from ActiveRecord::DeleteRestrictionError, with: :cannot_destroy_color

  def new
    @color = Color.new
    @product = Product.find(product_params)
  end


  def create
    @product = Product.find(product_params)
    @color = @product.colors.build(color_params)
    respond_to do |format|
      if @color.save
        flash.now[:notice] = "#{ @color.name } color created succesfully."
        format.js {}
      else
        format.js { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @color.update(color_params)
        flash.now[:notice] = "#{ @color.name } color updated succesfully."
        format.js {  }
      else
        format.js { render action: 'edit' }
      end
    end
  end

  def destroy
    @color.destroy
    respond_to do |format|
      flash.now[:notice] = "#{ @color.name } color destroyed succesfully."
      format.js {}
    end
  end

  private
  def set_color
    @color = Color.find(params[:id])
  end

  def product_params
    params.require(:product_id)
  end

  def color_params
    params.require(:color).permit!
  end

  def cannot_destroy_color
    respond_to do |format|
      flash.now[:notice] = "#{ @color.name } has sizes..It cannot be destroyed."
      format.js { render partial: 'notice' }
    end
  end
end
