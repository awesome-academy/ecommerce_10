class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details, dependent: :destroy
  enum status: {waiting: 0, delivering: 1, delivered: 2, cancel: 3}
  validates :name_order, presence: true
  validates :address_order, presence: true
  validates :phone_order, presence: true
end
