class OrdersController < ApplicationController
  def index; end

  def new
    unless logged_in?
      flash[:danger] = t "checkout.require_login"
      redirect_to login_path
    end
    @order = Order.new
    @carts =  load_cart_session
    @products = Product.find_multi_ids @carts.keys
    @sum_total = load_sum_total @carts, @products
  end

  def create
    @carts = load_cart_session
    return unless @carts
    Order.transaction do
      @order = current_user.orders.build order_param
      @order.save
      update_order_detail @carts, @order
      remove_all_cart
      flash[:success] = t "checkout.success"
      redirect_to root_path
    end
    rescue
      flash[:danger] = t "checkout.not_success"
      render :new
  end

  private
  def order_param
    params.require(:order).permit :name_order, :phone_order,
      :address_order, :total_amount
  end

  def update_order_detail carts, order
    carts.each do |product_id, quantity|
      order.order_details.create! product_id: product_id, quantity: quantity
    end
  end
end
