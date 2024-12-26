class ApplicationController < ActionController::API
  include ActionController::Cookies
  include ActionController::RequestForgeryProtection

  before_action :set_session_options

  private

  def set_session_options
    request.session_options[:expire_after] = 30.minutes
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate_user!
    unless current_user
      render json: { error: "You must be logged in to access this resource" },
             status: :unauthorized
    end
  end
end
