class CartsController < ApplicationController
  def add_to_cart
    product_id = params[:carts][:product_id]
    add_product_to_cart product_id
    redirect_to cart_path
  end

  def show
    @carts =  load_cart_session
    @products = Product.find_multi_ids @carts.keys
    # handle sum money
    @sum_total = load_sum_total @carts, @products
  end

  def update
    product_id = params[:product_id]
    quantity =  params[:quantity].to_i
    update_cart product_id, quantity
    redirect_to cart_path
  end

  def destroy
    product_id = params[:product_id]
    remove_product product_id
    flash[:danger] = t("cart.delete_success")
    redirect_to cart_path
  end
end
