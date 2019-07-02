class StaticPagesController < ApplicationController
  def home
    @hot_trend_products = load_trend_product
    @load_product_recentlys = load_product_recently
  end

  def search
    search_text = params[:p]
    flash[:danger] = t "product.product_invalid" if search_text.blank?
    Product.search_by_name(search_text).paginate page: params[:page],
      per_page: Settings.paginate_view_home
  end

  def help; end

  def contact; end
end
