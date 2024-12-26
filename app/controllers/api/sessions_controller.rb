class Api::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      Rails.logger.info "Session created: #{session.inspect}"

      render json: {
        status: :created,
        logged_in: true,
        user: user,
        session_id: request.session.id
      }
    else
      render json: { status: :unauthorized, error: "Invalid credentials" }, status: :unauthorized
    end
  end

  def destroy
    Rails.logger.info "Session before destroy: #{session.inspect}"
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
