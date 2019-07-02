class ProductsController < ApplicationController
  before_action :load_product, only: :show

  def show
    @product_news = Product.new_product.product_active
      .limit Settings.admin.product_limit
  end

  private

  def load_product
    @product = Product.find_by id: params[:id]
    return if @product
    flash[:danger] = t "product.product_invalid"
    redirect_to root_path
  end
end
