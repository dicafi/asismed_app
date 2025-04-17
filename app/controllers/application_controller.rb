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
    unless current_user && session[:session_token] == current_user.session_token
      reset_session
      redirect_to login_path, alert: 'You must be logged in to access this page.'
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def check_session_expiration
    if session[:last_seen_at] && session[:last_seen_at] < 10.minutes.ago
      reset_session
      redirect_to login_path, alert: 'Session has expired. Please log in again.'
    else
      session[:last_seen_at] = Time.current
    end
  end
end
