class Workout < ApplicationRecord
  belongs_to :user
  has_many :workout_exercises, dependent: :destroy
  has_many :exercises, through: :workout_exercises
  has_many :comments, dependent: :destroy

  validates :name, presence: true
end
