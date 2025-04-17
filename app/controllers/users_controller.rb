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

    if @user.update(user_params)
      reset_session
      redirect_to login_path, notice: 'Password updated successfully. Please log in again.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        if @user.saved_change_to_password_digest?
          if @user == current_user
            reset_session
            format.html {
              redirect_to login_path,
              notice: 'Password updated successfully. All sessions have been logged out. \
                Please log in again.'
            }
          else
            @user.update(session_token: nil)
            format.html {
              redirect_to @user, notice: 'Password updated successfully for the user. \
                Their session has been reset.'
            }
          end
        else
          format.html {
            redirect_to @user, notice: 'User was successfully updated.'
          }
        end
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy!

    respond_to do |format|
      format.html {
 redirect_to users_path, status: :see_other, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(
        :username,
        :password_digest,
        :profile,
        :last_name,
        :second_last_name,
        :first_name,
        :signature,
        :active
      )
    end
end
