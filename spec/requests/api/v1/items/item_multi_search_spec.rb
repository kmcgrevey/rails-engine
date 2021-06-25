require 'rails_helper'

RSpec.describe 'All Item search endpoint', type: :request do
  let!(:item1) { create(:item, name: 'Turing Gear',
                               unit_price: 20.00) }
  let!(:item2) { create(:item, name: 'Widget',
                               unit_price: 40.00) }
  let!(:item3) { create(:item, name: 'Ring Thing',
                               unit_price: 100.00) }
  let!(:item4) { create(:item, name: 'Erin Gear',
                               unit_price: 40.00) }
  
  describe 'returns Items using name query' do
    context 'with valid params' do
      let(:valid_name_param) { 'name=ring' }

      subject { get '/api/v1/items/find_all', params: valid_name_param}

      it 'has a successful 200 response' do
        subject
        expect(response).to have_http_status(:ok)
      end

      it 'as a list in alphabtical order' do
        subject
        expect(json_data.class).to eq(Array)
        expect(json_data.length).to eq(2)
        expect(json_data.first[:id]).to eq(item3.id.to_s)
        expect(json_data.last[:id]).to eq(item1.id.to_s)
      end
    end

    context 'with invalid params' do
      let(:invalid_name_param) { 'name=NOMATCH' }

      subject { get '/api/v1/items/find_all', params: invalid_name_param}

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
