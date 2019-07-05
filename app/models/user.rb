class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  before_save :dowcase_email
  has_many :orders, dependent: :destroy
  has_many :comments, dependent: :destroy
  enum role: {admin: 0, normal: 1}
  validates :name, presence: true,
    length: {maximum: Settings.length_name_maximum
  scope :user_activated, ->{where activated: true}

  private

  def dowcase_email
    email.downcase!
  end
end
