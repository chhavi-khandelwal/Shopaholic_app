class CartsController < ApplicationController
  before_action :set_cart, only: [:show]
  before_action :set_size, only: [:create]

  def create
    # session[:cart_id] = nil
    if(session[:cart_id])
      @cart = Cart.find_by(id: session[:cart_id])
    else
      @cart = Cart.new
      @cart.save
      session[:cart_id] = @cart.id
    end
    line_item = @cart.line_items.find_by(size_id: @size.id)
    if(line_item)
      line_item.quantity += 1
      line_item.save
    else
      @cart.sizes << @size
      @cart.save
    end

    render json: { cart_id: @cart.id, cart_size: @cart.line_items.count }
  end

  private
  def set_cart
    @cart = Cart.find_by(id: params[:id])
  end

  def set_size
    @size = Size.find_by(id: params[:size_id])
  end
end
