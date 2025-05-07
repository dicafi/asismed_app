require 'rails_helper'

RSpec.describe MaritalStatusesController, type: :controller do
  let!(:marital_status1) { create(:marital_status, description: 'Soltero(a)') }
  let!(:marital_status2) { create(:marital_status, description: 'Casado(a)') }
  let!(:user) { create(:user) }

  before do
    session[:user_id] = user.id
    session[:session_token] = user.session_token
  end

  describe 'GET #index' do
    it 'returns all marital statuses as JSON' do
      get :index

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq([
        {
          'id' => marital_status1.id,
          'description' =>
          'Soltero(a)',
          'created_at' => marital_status1.created_at.as_json,
          'updated_at' => marital_status1.updated_at.as_json
        },
        {
          'id' => marital_status2.id,
          'description' =>
          'Casado(a)',
          'created_at' => marital_status2.created_at.as_json,
          'updated_at' => marital_status2.updated_at.as_json
        }
      ])
    end
  end

  describe 'GET #show' do
    context 'when the ID exists' do
      it 'returns the marital status with the given ID as JSON' do
        get :show, params: { id: marital_status1.id }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq({
          'id' => marital_status1.id,
          'description' => 'Soltero(a)',
          'created_at' => marital_status1.created_at.as_json,
          'updated_at' => marital_status1.updated_at.as_json
        })
      end
    end

    context 'when the ID does not exist' do
      it 'returns a 404 status with an error message' do
        get :show, params: { id: 999 }

        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to eq({ 'error' => 'Estado civil no encontrado' })
      end
    end
  end
end
