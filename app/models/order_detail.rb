class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product

  delegate :name, :price, to: :product
  scope :trend_product, (lambda do
    group(:product_id)
       .order("SUM(quantity) DESC")
       .select("product_id")
       .limit(Settings.limit_product)
  end)
end
