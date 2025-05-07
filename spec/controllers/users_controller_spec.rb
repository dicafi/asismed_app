require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:user) { create(:user) }
  let!(:admin) { create(:user, profile: 'admin') }
  let!(:inactive_user) { create(:user, profile: 'inactive', active: false) }

  before do
    session[:user_id] = user.id
    session[:session_token] = user.session_token
  end

  describe 'GET #index' do
    it 'assigns all active users to @users' do
      get :index

      expect(response).to have_http_status(:ok)
      expect(assigns(:users)).to match_array([ admin, user ])
    end
  end

  describe 'GET #show' do
    context 'when user exists' do
      it 'assigns the requested user to @user' do
        get :show, params: { id: admin.id }

        expect(assigns(:user)).to eq(admin)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when user does not exist' do
      it 'redirects to the users index with an alert' do
        get :show, params: { id: SecureRandom.uuid }

        expect(response).to redirect_to(users_path)
        expect(flash[:alert]).to eq('Usuario no encontrado.')
      end
    end
  end

  describe 'GET #new' do
    it 'assigns a new user to @user' do
      get :new
      expect(assigns(:user)).to be_a_new(User)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new user and redirects to users index' do
        expect {
          post :create, params: { user: attributes_for(:user) }
        }.to change(User, :count).by(1)

        expect(response).to redirect_to(users_path)
        expect(flash[:notice]).to eq('Usuario creado correctamente.')
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new user and renders :edit' do
        expect {
          post :create, params: { user: attributes_for(:user, username: nil) }
        }.not_to change(User, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:new)
        expect(flash[:alert]).to eq('Error al crear al usuario.')
      end
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested user to @user' do
      get :edit, params: { id: user.id }

      expect(assigns(:user)).to eq(user)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PATCH/PUT #update' do
    context 'with valid attributes' do
      it 'updates the user and redirects' do
        patch :update, params: { id: user.id, user: { first_name: 'Updated' } }

        expect(user.reload.first_name).to eq('Updated')
        expect(response).to redirect_to(user)
        expect(flash[:notice]).to eq('Datos actualizados.')
      end
    end

    context 'with invalid attributes' do
      it 'does not update the user and renders :edit' do
        patch :update, params: { id: user.id, user: { username: nil } }

        expect(user.reload.username).not_to be_nil
        expect(flash[:alert]).to eq('Error al actualizar al usuario.')
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:edit)
      end
    end

    context 'when the password is updated' do
      before do
        allow_any_instance_of(User).to receive(:saved_change_to_password_digest?).and_return(true)
      end

      it 'calls handle_password_change' do
        expect(controller).to receive(:handle_password_change)

        patch :update, params: {
          id: user.id,
          user: {
            password: 'NewPassword123!',
            password_confirmation: 'NewPassword123!'
          }
        }
      end

      context 'when the user is the current user' do
        before do
          allow(controller).to receive(:current_user).and_return(user)
        end

        it 'resets the session and redirects to login' do
          patch :update, params: {
            id: user.id,
            user: {
              password: 'NewPassword123!',
              password_confirmation: 'NewPassword123!'
            }
          }

          expect(session[:user_id]).to be_nil
          expect(response).to redirect_to(login_path)
          expect(flash[:notice]).to eq('Contraseña actualizada. Por favor ingrese nuevamente.')
        end
      end

      context 'when the user is not the current user' do
        let(:other_user) { create(:user) }

        it 'invalidates the session token and redirects to the user profile' do
          patch :update, params: {
            id: other_user.id,
            user: {
              password: 'NewPassword123!',
              password_confirmation: 'NewPassword123!'
            }
          }

          expect(other_user.reload.session_token).to be_nil
          expect(response).to redirect_to(other_user)
          expect(flash[:notice]).to eq('Contraseña actualizada para el usuario. ' +
            'Se han terminado todas las sesiones del usuario.')
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when the user exists' do
      it 'deactivates the user and redirects to the users index' do
        expect {
          delete :destroy, params: { id: user.id }
        }.not_to change(User, :count)

        expect(user.reload.active).to be_falsey
        expect(response).to have_http_status(:see_other)
        expect(response).to redirect_to(users_path)
        expect(flash[:notice]).to eq('Usuario dado de baja correctamente.')
      end
    end

    context 'when the user does not exist' do
      it 'redirects to the users index with an alert' do
        delete :destroy, params: { id: SecureRandom.uuid }

        expect(response).to redirect_to(users_path)
        expect(flash[:alert]).to eq('Usuario no encontrado.')
      end
    end
  end
end
