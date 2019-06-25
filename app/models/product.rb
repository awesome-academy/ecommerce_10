class Product < ApplicationRecord
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :images, dependent: :destroy
  has_many :order_details, dependent: :destroy
  has_many :orders, through: :order_details
  enum status: {normal: 0, deleted: 1}
  delegate :name_category, to: :category
  accepts_nested_attributes_for :images, allow_destroy: true,
    reject_if: proc{|attributes| attributes["url_path"].blank?}
  scope :recently_view_product, (lambda do
    order(viewer: :DESC).limit(Settings.limit_product)
  end)
  scope :find_multi_ids, ->(ids){where id: ids}
  scope :product_active, ->{where status: 0}
  scope :search, ->(key){where("name LIKE ?", "%#{key}%")}
  scope :new_product, ->{order(created_at: :DESC)}

  validates :name_category, presence: true,
    length: {maximum: Settings.length_name_maximum}
  validates :description, presence: true
  validates :quantity, presence: true
  validates :price, presence: true
  validates :status, presence: true
  validates :category_id, presence: true
end
