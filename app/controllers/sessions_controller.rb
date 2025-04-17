class SessionsController < ApplicationController
  skip_before_action :require_login, only: [ :create, :new ]

  def new
  end

  def create
    user = User.find_by(username: params[:username])

    if user&.authenticate(params[:password])
      user.update(session_token: SecureRandom.hex(16))
      session[:session_token] = user.session_token
      session[:user_id] = user.id

      render json: { message: 'Login successful', user: user }, status: :ok
    else
      render json: { error: 'Invalid username or password' }, status: :unauthorized
    end
  end

  def destroy
    current_user&.update(session_token: nil)
    reset_session
    redirect_to login_path, notice: 'Logout successful'
  end
end
