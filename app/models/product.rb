class Product < ApplicationRecord
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :images, dependent: :destroy
  has_many :order_details, dependent: :destroy
  enum status: {normal: 0, deleted: 1}

  scope :recently_view_product, (lambda do
    order(viewer: :DESC).limit(Settings.limit_product)
  end)
  scope :find_multi_ids, ->(ids){where id: ids}
end
