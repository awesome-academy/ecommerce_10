class Category < ApplicationRecord
  has_many :products, dependent: :destroy
  scope :sort_by_name, ->{order :name}
end
