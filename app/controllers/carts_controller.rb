class CartsController < ApplicationController
  def add_to_cart
    product_id = params[:carts][:product_id].to_i
    add_product_to_cart product_id
    redirect_to cart_path
  end

  def show; end
end
