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
      redirect_to users_path, notice: 'Usuario creado correctamente.'
    else
      flash.now[:alert] = 'Error al crear al usuario.'
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    if @user.update(user_params)
      return handle_password_change if @user.saved_change_to_password_digest?

      redirect_to @user, notice: 'Datos actualizados.'
    else
      flash.now[:alert] = 'Error al actualizar al usuario.'
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.deactivate

    redirect_to users_path, status: :see_other, notice: 'Usuario dado de baja correctamente.'
  end

private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find_by(id: params.expect(:id))
      unless @user
        redirect_to users_path, alert: 'Usuario no encontrado.'
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
        :active,
        :office
      )
    end

    def handle_password_change
      if @user == current_user
        reset_session
        redirect_to login_path, notice: 'Contraseña actualizada. ' +
          'Por favor ingrese nuevamente.'
      else
        @user.update(session_token: nil)
        redirect_to @user, notice: 'Contraseña actualizada para el usuario. ' +
          'Se han terminado todas las sesiones del usuario.'
      end
    end
end
