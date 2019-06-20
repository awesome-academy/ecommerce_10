class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details, dependent: :destroy
  has_many :products, through: :order_details
  enum status: {waiting: 0, delivering: 1, delivered: 2, cancel: 3}
  validates :name_order, presence: true
  validates :address_order, presence: true
  validates :phone_order, presence: true
  scope :new_order, ->{order(created_at: :DESC)}
end
