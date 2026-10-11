class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :live_events
  has_one_attached :profile_image

  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true, on: :create
  validates :password_confirmation, presence: true, on: :create
end
