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

  def load_roles_option
    User.roles.map{|k, _v| [k, k]}
  end

  def load_status_option
    Product.statuses.map{|k, _v| [k, k]}
  end

  def load_categories_option
    Category.all.map{|product| [product.name_category, product.id]}
  end

  def execute_del_user user
    orders = user.orders.waiting
    orders.each(&:cancel!)
  end
end
