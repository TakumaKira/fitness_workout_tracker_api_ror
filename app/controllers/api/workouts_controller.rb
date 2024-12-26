class Api::WorkoutsController < ApplicationController
  before_action :authenticate_user!

  def index
    workouts = current_user.workouts
    render json: workouts
  end

  def create
    workout = current_user.workouts.build(workout_params)
    if workout.save
      render json: workout, status: :created
    else
      render json: { errors: workout.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def workout_params
    params.require(:workout).permit(:name, :description, :date)
  end
end
