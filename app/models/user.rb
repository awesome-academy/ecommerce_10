class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
  before_save :dowcase_email
  has_many :orders, dependent: :destroy
  has_many :comments, dependent: :destroy
  enum role: {admin: 0, normal: 1}
  validates :name, presence: true,
    length: {maximum: Settings.length_name_maximum}
  scope :user_activated, ->{where activated: true}

  def self.new_with_session params, session
    super.tap do |user|
      if data = session["devise.facebook_data"] &&
        session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] unless user&.email
      end
    end
  end

  def self.from_omniauth auth
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
      user.skip_confirmation!
      user.save
      user
    end
  end

  private

  def dowcase_email
    email.downcase!
  end
end
