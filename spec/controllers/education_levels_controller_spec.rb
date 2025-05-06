require 'rails_helper'

RSpec.describe EducationLevelsController, type: :controller do
  let!(:user) { create(:user) }

  before do
    session[:user_id] = user.id
    session[:session_token] = user.session_token
  end

  describe 'GET #index' do
    it 'returns all education levels as JSON' do
      get :index

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq(EducationLevel.all.as_json)
    end
  end

  describe 'GET #show' do
    context 'when the ID exists' do
      it 'returns the education level with the given ID as JSON' do
        get :show, params: { id: 1 }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq({
          'id' => '1',
          'description' => 'Primaria'
        })
      end
    end

    context 'when the ID does not exist' do
      it 'raises an error or returns a 404 status' do
        expect {
          get :show, params: { id: 999 }
        }.to raise_error(NoMethodError) # Ajusta esto si manejas errores personalizados
      end
    end
  end
end
