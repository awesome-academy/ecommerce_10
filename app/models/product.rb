class Product < ApplicationRecord
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :images, dependent: :destroy
  enum status: {normal: 0, deleted: 1}
end
