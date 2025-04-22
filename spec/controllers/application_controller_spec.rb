require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
    # Controlador anónimo para probar ApplicationController
    def index
      render plain: "OK"
    end
  end

  let(:user) { create(:user, session_token: SecureRandom.hex(16)) }

  describe '#require_login' do
    context 'when user is logged in' do
      before do
        session[:user_id] = user.id
        session[:session_token] = user.session_token
      end

      it 'allows access to the action' do
        get :index
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when user is not logged in' do
      it 'redirects to the login page' do
        get :index
        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq('You must be logged in to access this page.')
      end
    end

    context 'when session token does not match' do
      before do
        session[:user_id] = user.id
        session[:session_token] = 'invalid_token'
      end

      it 'resets the session and redirects to login' do
        get :index
        expect(session[:user_id]).to be_nil
        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq('You must be logged in to access this page.')
      end
    end
  end

  describe '#current_user' do
    context 'when user is logged in' do
      before do
        session[:user_id] = user.id
      end

      it 'returns the current user' do
        expect(controller.send(:current_user)).to eq(user)
      end
    end

    context 'when no user is logged in' do
      it 'returns nil' do
        expect(controller.send(:current_user)).to be_nil
      end
    end
  end

  describe '#check_session_expiration' do
    context 'when session has not expired' do
      before do
        session[:last_seen_at] = 5.minutes.ago
        session[:user_id] = user.id
        session[:session_token] = user.session_token
      end

      it 'does not reset the session' do
        get :index
        expect(session[:user_id]).to eq(user.id)
      end
    end

    context 'when session has expired' do
      before do
        session[:last_seen_at] = 35.minutes.ago
        session[:user_id] = user.id
        session[:session_token] = user.session_token
      end

      it 'resets the session and redirects to login' do
        get :index
        expect(session[:user_id]).to be_nil
        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq('Session has expired. Please log in again.')
      end
    end
  end

  describe 'Session invalidation after user deletion' do
    context 'when the user is deleted' do
      before do
        session[:user_id] = user.id
        session[:session_token] = user.session_token
        user.destroy # Eliminar al usuario
      end

      it 'resets the session and redirects to login' do
        get :index # Simular una solicitud después de la eliminación

        expect(session[:user_id]).to be_nil
        expect(session[:session_token]).to be_nil
        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq('You must be logged in to access this page.')
      end
    end
  end
end
