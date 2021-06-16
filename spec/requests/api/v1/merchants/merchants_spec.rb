require 'rails_helper'

# json_body & jason_data defined in ApiHelpers module to DRY, added to rails_helper

RSpec.describe 'Merchants API Endpoints', type: :request do
  let(:merch1) { create(:merchant) }
  let(:merch2) { create(:merchant) }

  describe 'returns a single Merchant' do
    subject { get "/api/v1/merchants/#{merch2.id}" }

    before { subject }

    it 'with a successful response' do
      expect(response).to be_successful
    end

    it 'with a proper JSON response' do
      expect(json_data[:id]).to eq(merch2.id.to_s)
      expect(json_data[:type]).to eq("merchant")
      expect(json_data[:attributes]).to eq(name: merch2.name)
    end
  end

  describe 'returns a list of Merchants' do
    subject { get "/api/v1/merchants" }

    it 'with a successful response' do
      create_list(:merchant, 5)
      subject

      expect(response).to be_successful
    end

    it 'with a proper JSON response' do
      merchants = create_list(:merchant, 5)
      subject

      expect(json_data.class).to be(Array)
      expect(json_data.length).to eq(5)
      expect(json_data.first[:type]).to eq("merchant")
      expect(json_data.first[:id]).to eq(merchants.first.id.to_s)
    end

    it 'with paginated results' do
      merchants_1 = create_list(:merchant, 10)
      merchants_2 = create_list(:merchant, 10)
      merchants_3 = create(:merchant)

      subject

      expect(json_data.length).to eq(20)
      expect(json_data.last[:id]).not_to eq(merchants_3.id)

      get "/api/v1/merchants?per_page=10&page=2"

      expect(json_data.length).to eq(10)
      expect(json_data.first[:id]).to eq(merchants_2.first.id.to_s)
      expect(json_data.last[:id]).to eq(merchants_2.last.id.to_s)
    end
  end

  describe 'returns a list of a Merchants items' do
    let!(:item1) { create(:item, merchant_id: merch1.id) }
    let!(:item2) { create(:item, merchant_id: merch2.id) }
    let!(:item3) { create(:item, merchant_id: merch2.id) }
    
    subject { get "/api/v1/merchants/#{merch2.id}/items" }

    before { subject }

    it 'with a successful response' do
      expect(response).to be_successful
    end

    it 'only returns its own items' do
      expect(json_data.length).to eq(2)
      expect(json_data.first[:id]).not_to eq(item1.id.to_s)
      expect(json_data.last[:id]).not_to eq(item1.id.to_s)
    end
  end

end
