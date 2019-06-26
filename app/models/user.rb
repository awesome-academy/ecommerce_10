class User < ApplicationRecord
  before_save :dowcase_email
  has_many :orders, dependent: :destroy
  has_many :comments, dependent: :destroy
  # has_many :suggestions, dependent: :destroy
  enum role: {admin: 0, normal: 1}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true,
    length: {maximum: Settings.length_name_maximum}
  validates :email, presence: true,
   length: {maximum: Settings.length_email_maximum},
   format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true,
   length: {minimum: Settings.length_password_minimum}

  has_secure_password

  scope :user_activated, ->{where activated: true}

  private

  def dowcase_email
    email.downcase!
  end
end
