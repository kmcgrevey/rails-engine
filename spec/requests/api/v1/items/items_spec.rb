require 'rails_helper'

RSpec.describe 'Items API Endpoints', type: :request do

  
  describe 'returns a list of Items' do
    let!(:items) { create_list(:item, 5)}
      
    subject { get "/api/v1/items" }

    it 'with a successful response' do
      subject
      expect(response).to be_successful
    end

    it 'with a proper JSON response' do
      subject

      expect(json_data.class).to be(Array)
      expect(json_data.length).to eq(5)
      expect(json_data.first[:type]).to eq("item")
      expect(json_data.first[:id]).to eq(items.first.id.to_s)
    end

    it 'with paginated results' do
      items2 = create_list(:item, 5)
      items3 = create_list(:item, 10)
      items4 = create(:item)

      subject

      expect(json_data.length).to eq(20)
      expect(json_data.last[:id]).not_to eq(items4.id)

      get "/api/v1/items?per_page=5&page=2"

      expect(json_data.length).to eq(5)
      expect(json_data.first[:id]).to eq(items2.first.id.to_s)
      expect(json_data.last[:id]).to eq(items2.last.id.to_s)
    end
  end

  describe 'returns a single Item' do
    let!(:item1) { create(:item) }
    let!(:item2) { create(:item) }
    
    subject { get "/api/v1/items/#{item2.id}" }

    before { subject }

    it 'with a successful response' do
      expect(response).to be_successful
    end

    it 'with a proper JSON response' do
      expect(json_data.class).to eq(Hash)
      expect(json_data.length).to eq(3)
      expect(json_data[:id]).to eq(item2.id.to_s)
      expect(json_data[:type]).to eq("item")
      expect(json_data[:attributes][:name]).to eq(item2.name)
      expect(json_data[:attributes][:description]).to eq(item2.description)
      expect(json_data[:attributes][:unit_price]).to eq(item2.unit_price)
    end
  end

end
