require 'rails_helper'

RSpec.describe 'Single Merchant search endpoint', type: :request do
  let!(:merchant1) { create(:merchant, name: 'Turing Guy') }
  let!(:merchant2) { create(:merchant, name: 'Widgette') }
  let!(:merchant3) { create(:merchant, name: 'Bing Ring') }
  let!(:merchant4) { create(:merchant, name: 'Erin Grey') }

  describe 'returns Merchants using name query' do
    context 'with valid params' do
      let(:valid_name_param) { 'name=ring' }

      subject { get '/api/v1/merchants/find_all', params: valid_name_param}

      it 'has a successful 200 response' do
        subject
        expect(response).to have_http_status(:ok)
      end

      it 'as a list in alphabtical order' do
        subject
        expect(json_data.class).to eq(Array)
        expect(json_data.length).to eq(2)
        expect(json_data.first[:id]).to eq(merchant3.id.to_s)
        expect(json_data.last[:id]).to eq(merchant1.id.to_s)
      end
    end

    context 'with invalid params' do
      let(:invalid_name_param) { 'name=NOMATCH' }

      subject { get '/api/v1/merchants/find_all', params: invalid_name_param}

      it 'has a successful 200 response' do
        subject
        expect(response).to have_http_status(:ok)
      end

      it 'returns a valid JSON formatted response' do
        subject
        expect(json_data.class).to eq(Array)
        expect(json_data.length).to eq(0)
      end
    end
  end

end
