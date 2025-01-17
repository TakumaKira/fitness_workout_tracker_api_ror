class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, on: :create

  has_many :workouts
  has_many :exercises
end
