class StaticPagesController < ApplicationController
  def home
    @hot_trend_products = load_trend_product
    @load_product_recentlys = load_product_recently
  end

  def help; end

  def contact; end
end
