class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    @users = User.active
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path, notice: 'User was successfully created.'
    else
      flash.now[:alert] = 'There was an error creating the user.'
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    if @user.update(user_params)
      return handle_password_change if @user.saved_change_to_password_digest?

      redirect_to @user, notice: 'User was successfully updated.'
    else
      flash.now[:alert] = 'There was an error updating the user.'
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy!

    redirect_to users_path, status: :see_other, notice: 'User was successfully destroyed.'
  end

private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find_by(id: params.expect(:id))
      unless @user
        redirect_to users_path, alert: 'User not found.'
      end
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(
        :username,
        :password,
        :password_confirmation,
        :profile,
        :last_name,
        :second_last_name,
        :first_name,
        :signature,
        :active
      )
    end

    def handle_password_change
      if @user == current_user
        reset_session
        redirect_to login_path, notice: 'Password updated successfully. ' +
          'All sessions have been logged out. Please log in again.'
      else
        @user.update(session_token: nil)
        redirect_to @user, notice: 'Password updated successfully for the user. ' +
          'Their session has been reset.'
      end
    end
end
