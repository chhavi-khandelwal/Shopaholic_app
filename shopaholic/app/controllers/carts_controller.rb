class CartsController < ApplicationController
  before_action :set_cart, only: [:show]
  before_action :set_size, only: [:create]
  before_action :set_cart_by_session, only: [:create]

  def payment
    quantity = params[:quantities]
    Size.where(id: params[:ids]).each_with_index do |size,index|
      size.quantity -= quantity[index].to_i
      size.save
    end
  end

  def create
    line_item = @cart.line_items.find_by(size_id: @size.id)
    @cart.update_cart(line_item, @size)

    render json: { cart_id: @cart.id, cart_size: @cart.line_items.count }
  end

  private
  def set_cart
    @cart = Cart.find_by(id: params[:id])
  end

  def set_size
    @size = Size.find_by(id: params[:size_id])
  end

  def set_cart_by_session
    # session[:cart_id] = nil
    if(session[:cart_id])
      @cart = Cart.find_by(id: session[:cart_id])
    else
      @cart = Cart.new
      session[:cart_id] = @cart.id
    end
  end
end
