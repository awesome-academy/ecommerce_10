class Admin::OrderDetailsController < ApplicationController
  layout "application_admin"

  def show
    @order = Order.find_by id: params[:id]
    return unless @order
    @order_details = @order.order_details
  end
end
