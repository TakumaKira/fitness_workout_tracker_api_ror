class AddIndexesToExercisesAndWorkoutExercises < ActiveRecord::Migration[8.0]
  def change
    add_index :exercises, :name
    add_index :workout_exercises, [ :workout_id, :exercise_id ]
  end
end
