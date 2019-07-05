class OrdersController < ApplicationController
  before_action :authenticate_user!, only: %i(index new create)
  before_action :load_orders, only: :destroy

  def index
    @orders = current_user.orders.new_order.paginate page: params[:page],
      per_page: Settings.history_order
  end

  def new
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
      decrease_number_product @order, @carts
      send_mails current_user, @order, @carts
      remove_all_cart
      flash[:success] = t "checkout.success"
      redirect_to root_path
    end
    rescue
      flash[:danger] = t "checkout.not_success"
      render :new
  end

  def destroy
    Order.transaction do
      @order.update_attribute :status, Settings.order.cancle
      increase_number_product @order
      flash[:success] = t "order.order_cancle"
      redirect_to orders_path
    end
    rescue
      flash[:danger] = t "order.order_cancle_error"
      render :index
  end

  private

  def load_orders
    @order = Order.find_by id: params[:id]
    return if @order
    flash[:danger] = t "order.invalid"
    redirect_to orders_path
  end

  def decrease_number_product order, cart
    order.products.each do |product|
      number = product.quantity - cart[product.id.to_s]
      product.update_attribute :quantity, number
    end
  end

  def increase_number_product order
    order.order_details.each do |order_detail|
      product_quantity = get_product(order_detail).quantity
      number = product_quantity + order_detail.quantity
      product = get_product order_detail
      product.update_attribute :quantity, number
    end
  end

  def order_param
    params.require(:order).permit :name_order, :phone_order,
      :address_order, :total_amount
  end

  def update_order_detail carts, order
    carts.each do |product_id, quantity|
      order.order_details.create! product_id: product_id, quantity: quantity
    end
  end

  def send_mails user, order, carts
    OrderMailer.order_email(user, order, carts).deliver
  end
end
