class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details, dependent: :destroy
  enum status: {waiting: 0, delivering: 1, delivered: 2, cancel: 3}
end
