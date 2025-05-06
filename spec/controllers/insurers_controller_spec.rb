require 'rails_helper'

RSpec.describe InsurersController, type: :controller do
  let!(:user) { create(:user) }
  let!(:insurer1) { create(:insurer, description: 'IMSS') }
  let!(:insurer2) { create(:insurer, description: 'ISSSTE') }

  before do
    session[:user_id] = user.id
    session[:session_token] = user.session_token
  end

  describe 'GET #index' do
    it 'returns all insurers as JSON' do
      get :index

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq([
        {
          'id' => insurer1.id,
          'description' => 'IMSS',
          'created_at' => insurer1.created_at.as_json,
          'updated_at' => insurer1.updated_at.as_json },
        {
          'id' => insurer2.id,
          'description' => 'ISSSTE',
          'created_at' => insurer2.created_at.as_json,
          'updated_at' => insurer2.updated_at.as_json
        }
      ])
    end
  end

  describe 'GET #show' do
    context 'when the ID exists' do
      it 'returns the insurer with the given ID as JSON' do
        get :show, params: { id: insurer1.id }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq({
          'id' => insurer1.id,
          'description' => 'IMSS',
          'created_at' => insurer1.created_at.as_json,
          'updated_at' => insurer1.updated_at.as_json
        })
      end
    end

    context 'when the ID does not exist' do
      it 'returns a 404 status with an error message' do
        get :show, params: { id: 999 }

        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to eq({ 'error' => 'Insurer not found' })
      end
    end
  end
end
