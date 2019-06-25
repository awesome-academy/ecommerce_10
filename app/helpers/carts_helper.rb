module CartsHelper
  def load_cart_session
    @carts = session[:carts].present? ? JSON.parse(session[:carts]) : Hash.new
  end

  def add_product_to_cart product_id, quantity = 1
    product = Product.find_by id: product_id.to_i
    return flash[:danger] = I18n.t("cart.add_fail") unless product
    load_cart_session
    if @carts.key? product_id
      @carts[product_id] += quantity
    else
      @carts[product_id] = quantity
    end
    if @carts[product_id] > product.quantity
      return flash[:danger] = I18n.t("cart.over_quantity")
    else
      save_cart_to_session
      flash[:success] = I18n.t("cart.add_success")
    end
  end

  def save_cart_to_session
    session[:carts] = JSON.generate @carts
  end

  def update_cart product_id, quantity
    product = Product.find_by id: product_id.to_i
    return flash[:danger] = I18n.t("cart.product_not_exits") unless product

    load_cart_session
    return flash[:danger] = I18n.t("cart.update_fail") unless @carts.key? product_id
    @carts[product_id] = quantity
    if @carts[product_id] > product.quantity
      return flash[:danger] = I18n.t("cart.over_quantity")
    else
      save_cart_to_session
      flash[:success] = I18n.t("cart.add_success")
    end
  end

  def calculator_amount quantity, price
    quantity * price
  end

  def load_size_cart
    load_cart_session
    @carts.size
  end

  def load_sum_total carts, products
    result = 0
    products.each do |product|
      result += product.price * carts[product.id.to_s]
    end
    result
  end

  def remove_product product_id
    load_cart_session
    return @carts unless @carts.key? product_id
    @carts.delete product_id
    save_cart_to_session
  end

  def remove_all_cart
    session[:carts] = JSON.generate Hash.new
  end
end
