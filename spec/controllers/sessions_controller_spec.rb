require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:user) { create(:user, password: 'Password123!', password_confirmation: 'Password123!') }

  describe 'GET #new' do
    it 'renders the login form' do
      get :new
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid credentials' do
      it 'authenticates the user and sets the session' do
        post :create, params: { username: user.username, password: 'Password123!' }

        expect(response).to have_http_status(:ok)
        expect(session[:user_id]).to eq(user.id)
        expect(session[:session_token]).to eq(user.reload.session_token)
        expect(JSON.parse(response.body)['message']).to eq('Login successful')
      end
    end

    context 'with invalid credentials' do
      it 'returns an unauthorized status' do
        post :create, params: { username: user.username, password: 'WrongPassword' }

        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)['error']).to eq('Invalid username or password')
        expect(session[:user_id]).to be_nil
        expect(session[:session_token]).to be_nil
      end
    end

    context 'with non-existent user' do
      it 'returns an unauthorized status' do
        post :create, params: { username: 'nonexistent@example.com', password: 'Password123!' }

        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)['error']).to eq('Invalid username or password')
        expect(session[:user_id]).to be_nil
        expect(session[:session_token]).to be_nil
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when user is logged in' do
      before do
        session[:user_id] = user.id
        session[:session_token] = user.session_token
      end

      it 'logs out the user and resets the session' do
        delete :destroy

        expect(response).to redirect_to(login_path)
        expect(flash[:notice]).to eq('Logout successful')
        expect(session[:user_id]).to be_nil
        expect(session[:session_token]).to be_nil
        expect(user.reload.session_token).to be_nil
      end
    end

    context 'when no user is logged in' do
      it 'does nothing and redirects to login' do
        delete :destroy

        expect(response).to redirect_to(login_path)
        expect(flash[:notice]).to be_nil
        expect(session[:user_id]).to be_nil
        expect(session[:session_token]).to be_nil
      end
    end
  end
end
