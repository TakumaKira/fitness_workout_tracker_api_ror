class Api::WorkoutExercisesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_workout
  before_action :set_workout_exercise, only: [ :show, :update, :destroy ]

  def index
    workout_exercises = @workout.workout_exercises.includes(:exercise)
    render json: workout_exercises
  end

  def show
    render json: @workout_exercise
  end

  def create
    workout_exercise = @workout.workout_exercises.build(workout_exercise_params)
    if workout_exercise.save
      render json: workout_exercise, status: :created
    else
      render json: { errors: workout_exercise.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def batch_create
    workout_exercises = params[:workout_exercises].map do |we_params|
      @workout.workout_exercises.build(
        exercise_id: we_params[:exercise_id],
        sets: we_params[:sets],
        reps: we_params[:reps],
        weight: we_params[:weight]
      )
    end

    if workout_exercises.all?(&:valid?)
      WorkoutExercise.transaction do
        workout_exercises.each(&:save!)
      end
      render json: workout_exercises, status: :created
    else
      errors = workout_exercises.flat_map { |we| we.errors.full_messages }
      render json: { errors: errors }, status: :unprocessable_entity
    end
  end

  def update
    if @workout_exercise.update(workout_exercise_params)
      render json: @workout_exercise
    else
      render json: { errors: @workout_exercise.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @workout_exercise.destroy
    head :no_content
  end

  private

  def set_workout
    @workout = current_user.workouts.find(params[:workout_id])
  end

  def set_workout_exercise
    @workout_exercise = @workout.workout_exercises.find(params[:id])
  end

  def workout_exercise_params
    params.require(:workout_exercise).permit(:exercise_id, :sets, :reps, :weight)
  end
end
