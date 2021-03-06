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

    context 'with invalid params' do
      let(:invalid_price_param) { 'min_price=-5' }

      it 'has a 400 response' do
        get '/api/v1/items/find', params: invalid_price_param
        
        expect(response).to have_http_status(:bad_request)
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

  describe 'returns an error for invalid query combos' do
    subject { get '/api/v1/items/find', params: invalid_combo }
    
    context 'name & min_price' do
      let(:invalid_combo)  { 'min_price=30&name=ring' }
      
      it 'has a 400 response' do
        subject
        expect(response).to have_http_status(:bad_request)
      end
    end
    
    context 'name & max_price' do
      let(:invalid_combo)  { 'name=ring&max_price=30' }
      
      it 'has a 400 response' do
        subject
        expect(response).to have_http_status(:bad_request)
      end
    end
    
    context 'max_price & min_price & name' do
      let(:invalid_combo)  { 'min_price=10&name=ring&max_price=30' }
      
      it 'has a 400 response' do
        subject
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

end