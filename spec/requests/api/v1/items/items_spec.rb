require 'rails_helper'

RSpec.describe 'Items API Endpoints', type: :request do
  # let(:merch1) { create(:merchant) }
  # let(:merch2) { create(:merchant) }
  
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

end
