class Api::ExercisesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_exercise, only: [ :show, :update, :destroy ]

  def index
    exercises = current_user.exercises
    render json: exercises
  end

  def show
    render json: @exercise
  end

  def create
    exercise = current_user.exercises.build(exercise_params)
    if exercise.save
      render json: exercise, status: :created
    else
      render json: { errors: exercise.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @exercise.update(exercise_params)
      render json: @exercise
    else
      render json: { errors: @exercise.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @exercise.destroy
    head :no_content
  end

  private

  def set_exercise
    @exercise = current_user.exercises.find(params[:id])
  end

  def exercise_params
    params.require(:exercise).permit(:name, :description)
  end
end
