class Admin::ColorsController < ApplicationController
  before_action :set_color, only: [:update, :destroy, :edit, :cannot_destroy_color]
  before_action :set_product, only: [:new, :create]
  rescue_from ActiveRecord::DeleteRestrictionError, with: :cannot_destroy_color

  def new
    @color = Color.new
  end


  def create
    @color = @product.colors.build(color_params)
    respond_to do |format|
      if @color.save
        @colors = @product.colors
        flash.now[:notice] = "#{ @color.name } color created successfully."
        format.html { redirect_to admin_product_path(@product), notice: 'Color was successfully created.' }
      else
        format.html { render action: 'new'}
      end
    end
  end

  def update
    respond_to do |format|
      if @color.update(color_params)
        flash.now[:notice] = "#{ @color.name } color updated successfully."
        format.html { redirect_to admin_product_path(@color.product), notice: 'Color was successfully created.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @color.destroy
    respond_to do |format|
      flash.now[:notice] = "#{ @color.name } color destroyed successfully."
      format.js {}
    end
  end

  private
  def set_color
    @color = Color.find(params[:id])
  end

  def set_product
    @product = Product.find(params.require(:product_id))
  end

  def color_params
    params.require(:color).permit(:name, images_attributes: [:id, :display_pic])
  end

  def cannot_destroy_color
    respond_to do |format|
      flash.now[:notice] = "#{ @color.name } has sizes..It cannot be destroyed."
      format.js { render partial: 'notice' }
    end
  end
end
