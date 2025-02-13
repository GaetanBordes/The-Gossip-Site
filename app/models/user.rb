class User < ApplicationRecord
  has_secure_password
  has_many :gossips, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :city, presence: true
  validates :birth_date, presence: true
  validates :description, presence: true
end
