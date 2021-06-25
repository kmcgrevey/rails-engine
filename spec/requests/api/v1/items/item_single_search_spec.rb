require 'rails_helper'

RSpec.describe 'Single Item search endpoint', type: :request do
  describe 'returns Item using name query' do
    let!(:item1) { create(:item, name: 'Turing Gear') }
    let!(:item2) { create(:item, name: 'Widget') }
    let!(:item3) { create(:item, name: 'Ring Thing') }
    let!(:item4) { create(:item, name: 'Erin Gear') }

    context 'with valid params' do
      let(:valid_name_param) { 'name=ring'}

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
  end

end