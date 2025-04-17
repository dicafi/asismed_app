class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:create]

  def create
    user = User.find_by(username: params[:username])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      render json: { message: 'Login successful', user: user }, status: :ok
    else
      render json: { error: 'Invalid username or password' }, status: :unauthorized
    end
  end

  def destroy
    session[:user_id] = nil
    render json: { message: 'Logout successful' }, status: :ok
  end
end
