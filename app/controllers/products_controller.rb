class ProductsController < ApplicationController
  before_action :load_product, only: :show
  def show
    @product_news = Product.new_product.product_active.limit(5)
  end

  private

  def load_product
    @product = Product.find params[:id]
    return if @product
    flash[:danger] = "Product invalid"
  end
end
