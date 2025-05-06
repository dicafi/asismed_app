require 'rails_helper'

RSpec.describe MaritalStatusesController, type: :controller do
  let!(:user) { create(:user) }

  before do
    session[:user_id] = user.id
    session[:session_token] = user.session_token
  end

  describe 'GET #index' do
    it 'returns all marital statuses as JSON' do
      get :index

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq(MaritalStatus.all.as_json)
    end
  end

  describe 'GET #show' do
    context 'when the ID exists' do
      it 'returns the marital status with the given ID as JSON' do
        get :show, params: { id: 1 }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq({
          'id' => 1,
          'description' => 'Casado(a)'
        })
      end
    end

    context 'when the ID does not exist' do
      it 'returns a 404 status with an error message' do
        get :show, params: { id: 999 }

        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to eq({ 'error' => 'Marital status not found' })
      end
    end
  end
end
