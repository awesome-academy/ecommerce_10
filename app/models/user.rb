class User < ApplicationRecord
  has_many :orders, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :suggestions, dependent: :destroy
end
