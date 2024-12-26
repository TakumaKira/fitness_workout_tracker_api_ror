class Api::WorkoutsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_workout, only: [ :show, :update, :destroy ]

  def index
    workouts = current_user.workouts
    render json: workouts
  end

  def show
    render json: @workout
  end

  def create
    workout = current_user.workouts.build(workout_params)
    if workout.save
      render json: workout, status: :created
    else
      render json: { errors: workout.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @workout.update(workout_params)
      render json: @workout
    else
      render json: { errors: @workout.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @workout.destroy
    head :no_content
  end

  private

  def set_workout
    @workout = current_user.workouts.find(params[:id])
  end

  def workout_params
    params.require(:workout).permit(:name, :date)
  end
end
