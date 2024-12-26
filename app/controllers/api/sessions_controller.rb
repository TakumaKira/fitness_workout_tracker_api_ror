class Api::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      render json: { status: :created, logged_in: true, user: user }
    else
      render json: { status: :unauthorized, error: "Invalid credentials" }, status: :unauthorized
    end
  end

  def destroy
    session[:user_id] = nil
    render json: { status: :ok, logged_out: true }
  end

  def logged_in
    if current_user
      render json: { logged_in: true, user: current_user }
    else
      render json: { logged_in: false }
    end
  end
end
