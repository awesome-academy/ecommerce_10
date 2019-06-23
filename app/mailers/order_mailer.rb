class OrderMailer < ApplicationMailer
  default from: "phanthanhdong14@gmail.com"

  def order_email user, order, carts
    @user = user
    @order = order
    @carts = carts
    @total_price = sum_total_price @order, @carts
    mail to: @user.email, subject: t("order.subject")
  end

  private

  def sum_total_price order, carts
    result = 0
    order.products.each do |product|
      result += product.price * carts[product.id.to_s]
    end
    result
  end
end
