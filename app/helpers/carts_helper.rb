module CartsHelper
  def load_cart_session
    @carts = session[:carts].present? ? JSON.parse(session[:carts]) : Hash.new
  end

  def add_product_to_cart product_id, quantity = 1
    product = Product.find_by id: product_id
    if product.nil?
      return flash[:danger] = I18n.t("cart.add_fail")
    end
    load_cart_session
    if @carts.key product_id
      @carts[product_id] += quantity
    else
      @carts[product_id] = quantity
    end

    if @carts[product_id] > product.quantity
      @carts[product_id] = product.quantity
      flash[:danger] = I18n.t("cart.add_fail")
    else
      save_cart_to_session
      flash[:success] = I18n.t("cart.add_success")
    end
  end

  def save_cart_to_session
    session[:carts] = JSON.generate @carts
  end
end
