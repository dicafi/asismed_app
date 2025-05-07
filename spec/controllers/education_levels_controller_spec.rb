require 'rails_helper'

RSpec.describe EducationLevelsController, type: :controller do
  let!(:education_level1) { create(:education_level, description: 'Primaria') }
  let!(:education_level2) { create(:education_level, description: 'Secundaria') }
  let!(:user) { create(:user) }

  before do
    session[:user_id] = user.id
    session[:session_token] = user.session_token
  end

  describe 'GET #index' do
    it 'returns all education levels as JSON' do
      get :index

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq([
        {
          'id' => education_level1.id,
          'description' =>
          'Primaria',
          'created_at' => education_level1.created_at.as_json,
          'updated_at' => education_level1.updated_at.as_json
        },
        {
          'id' => education_level2.id,
          'description' =>
          'Secundaria',
          'created_at' => education_level2.created_at.as_json,
          'updated_at' => education_level2.updated_at.as_json
        }
      ])
    end
  end

  describe 'GET #show' do
    context 'when the ID exists' do
      it 'returns the education level with the given ID as JSON' do
        get :show, params: { id: education_level1.id }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq({
          'id' => education_level1.id,
          'description' => 'Primaria',
          'created_at' => education_level1.created_at.as_json,
          'updated_at' => education_level1.updated_at.as_json
        })
      end
    end

    context 'when the ID does not exist' do
      it 'returns a 404 status with an error message' do
        get :show, params: { id: 999 }

        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to eq({ 'error' => 'Nivel educativo no encontrado' })
      end
    end
  end
end
