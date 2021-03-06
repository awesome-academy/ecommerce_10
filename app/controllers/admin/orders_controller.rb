class Admin::OrdersController < Admin::BaseController
  layout "application_admin"
  before_action :load_orders, only: %i(edit update)

  def index
    @search = Order.search params[:q]
    @orders = @search.result.new_order.paginate page: params[:page],
      per_page: Settings.admin.product_limit
    @search.build_condition
  end

  def edit; end

  def update
    if @order.update_attribute :status, params[:order][:status]
      send_mails @order
      flash[:success] = t "admin.update_success"
      redirect_to admin_orders_path
    else
      flash[:danger] = t "admin.update_fail"
      render :edit
    end
  end

  private

  def load_orders
    @order = Order.find_by id: params[:id]
    return if @order
    flash[:danger] = "Order invalid"
    redirect_to orders_path
  end

  def order_params
    params.require(:order).permit :name_order, :address_order,
      :phone_order, :total_amount, :status
  end

  def send_mails order
    OrderMailer.update_order(order).deliver
  end
end
