class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :live_events
  has_one_attached :profile_image

  # ゲストログイン用
  def guest?
    email == "guest@example.com"
  end
  
  def self.guest
    find_or_create_by!(email: "guest@example.com") do |user|
      password = SecureRandom.urlsafe_base64
      user.password = password
      user.password_confirmation = password
      user.name = "ゲスト"
    end
  end

  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true, on: :create
  validates :password_confirmation, presence: true, on: :create
end
