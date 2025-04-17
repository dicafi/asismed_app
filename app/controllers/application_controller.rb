class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting,
  # and CSS :has.
  allow_browser versions: :modern
  before_action :require_login
  before_action :check_session_expiration
  # ! -------------------------------------------
  # !   Remove comment to enable authentication
  # ! -------------------------------------------
  skip_before_action :verify_authenticity_token

  private

  def require_login
    unless session[:user_id]
      render json: { error: 'Unauthorized access' }, status: :unauthorized
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def check_session_expiration
    if session[:last_seen_at] && session[:last_seen_at] < 1.minutes.ago
      reset_session
      render json: { error: 'Session has expired. Please log in again.' }, status: :unauthorized
    else
      session[:last_seen_at] = Time.current
    end
  end
end
