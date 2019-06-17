module ApplicationHelper
  def load_trend_product
    OrderDetail.trend_product
  end

  def load_product_recently
    Product.recently_view_product
  end

  def get_image image
    return unless image
    image.images.first.url_path
  end
end
