class Exercise < ApplicationRecord
  belongs_to :user
  has_many :workout_exercises
  has_many :workouts, through: :workout_exercises

  validates :name, presence: true
end
