class Category < ApplicationRecord
  has_many :products, dependent: :destroy
  validates :name_category, presence: true,
    length: {minimum: Settings.category.length_minimum}
  validates :description, presence: true,
    length: {minimum: Settings.description.length_minimum}
  scope :sort_by_name, ->{order :name}
end
