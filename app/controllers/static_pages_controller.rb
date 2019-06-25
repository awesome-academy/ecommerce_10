class StaticPagesController < ApplicationController
  def home
    @hot_trend_products = load_trend_product
    @load_product_recentlys = load_product_recently
  end

  def search
    search_text = params[:p]
    @products = if search_text.blank?
                flash[:danger] = "Product not found"
                Product.product_active.paginate page: params[:page],
                  per_page: Settings.paginate_view_home
              else
                Product.where("name LIKE ?", "%#{search_text}%").paginate page: params[:page],
                  per_page: Settings.paginate_view_home
              end
  end

  def help; end

  def contact; end
end
