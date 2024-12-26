class Api::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_workout
  before_action :set_comment, only: [ :update, :destroy ]

  def index
    comments = @workout.comments.includes(:user).order(created_at: :desc)
    render json: comments
  end

  def create
    comment = @workout.comments.build(comment_params)
    comment.user = current_user

    if comment.save
      render json: comment, status: :created
    else
      render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @comment.user_id == current_user.id
      if @comment.update(comment_params)
        render json: @comment
      else
        render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: "You can only edit your own comments" }, status: :forbidden
    end
  end

  def destroy
    if @comment.user_id == current_user.id
      @comment.destroy
      head :no_content
    else
      render json: { error: "You can only delete your own comments" }, status: :forbidden
    end
  end

  private

  def set_workout
    @workout = Workout.find(params[:workout_id])
  end

  def set_comment
    @comment = @workout.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
