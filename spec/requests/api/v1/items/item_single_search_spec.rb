require 'rails_helper'

RSpec.describe 'Single Item search endpoint', type: :request do
  let!(:item1) { create(:item, name: 'Turing Gear',
                               unit_price: 20.00) }
  let!(:item2) { create(:item, name: 'Widget',
                               unit_price: 40.00) }
  let!(:item3) { create(:item, name: 'Ring Thing',
                               unit_price: 100.00) }
  let!(:item4) { create(:item, name: 'Erin Gear',
                               unit_price: 40.00) }
  
  describe 'returns Item using name query' do
    context 'with valid params' do
      let(:valid_name_param) { 'name=ring' }

      subject { get '/api/v1/items/find', params: valid_name_param}

      it 'has a successful 200 response' do
        subject
        expect(response).to have_http_status(:ok)
      end

      it 'is the first record in alphabtical order' do
        subject
        expect(json_data.class).to eq(Hash)
        expect(json_data[:id]).to eq(item3.id.to_s)
      end
    end

    context 'with invalid params' do
      let(:invalid_name_param) { 'name=NOMATCH' }

      subject { get '/api/v1/items/find', params: invalid_name_param}

      it 'has a successful 200 response' do
        subject
        expect(response).to have_http_status(:ok)
      end

      it 'returns a valid JSON formatted response' do
        subject
        expect(json_data.class).to eq(Hash)
        expect(json_data.length).to eq(0)
      end
    end
  end
  
  describe 'returns Item using min_price query' do
    context 'with valid params' do
      let(:valid_price_param) { 'min_price=40' }

      subject { get '/api/v1/items/find', params: valid_price_param}

      it 'has a successful 200 response' do
        subject
        expect(response).to have_http_status(:ok)
      end

      it 'is the first record in alphabtical order' do
        subject
        expect(json_data.class).to eq(Hash)
        expect(json_data[:id]).to eq(item4.id.to_s)
        expect(json_data[:attributes][:unit_price]).to eq(item4.unit_price)
      end
    end
  end
  
  describe 'returns Item using max_price query' do
    context 'with valid params' do
      let(:valid_price_param) { 'max_price=30' }

      subject { get '/api/v1/items/find', params: valid_price_param}

      it 'has a successful 200 response' do
        subject
        expect(response).to have_http_status(:ok)
      end

      it 'gets the record' do
        subject
        expect(json_data.class).to eq(Hash)
        expect(json_data[:id]).to eq(item1.id.to_s)
        expect(json_data[:attributes][:unit_price]).to eq(item1.unit_price)
      end
    end
  end
  
  describe 'returns Item using min_price and max_price query' do
    context 'with valid params' do
      let(:valid_price_param) { 'max_price=60&min_price=30' }

      subject { get '/api/v1/items/find', params: valid_price_param}

      it 'has a successful 200 response' do
        subject
        expect(response).to have_http_status(:ok)
      end

      it 'is the first record in alphabtical order' do
        subject
        expect(json_data.class).to eq(Hash)
        expect(json_data[:id]).to eq(item4.id.to_s)
        expect(json_data[:attributes][:unit_price]).to eq(item4.unit_price)
      end
    end
  end

end