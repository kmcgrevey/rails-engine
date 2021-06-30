require 'rails_helper'

RSpec.describe 'Merchant with Most Revenue endpoint', type: :request do
  before (:each) do
    inv_items = create_list(:invoice_item, 5)
    inv_items.each { |item| item.invoice.transactions.create(result: 'success') }
  end

  subject { get '/api/v1/revenue/merchants?quantity=3' }

  it 'returns a successful response' do
    subject
    expect(response).to be_successful
  end

  it 'returns a proper JSON response' do
    subject
    expect(json_data.first[:type]).to eq('merchant_name_revenue')
    expect(json_data.first[:attributes]).to have_key(:name)
    expect(json_data.first[:attributes]).to have_key(:revenue)
  end
  
  it 'returns list limited to qty requested' do
    subject
    expect(json_data.length).to eq(3)

    get '/api/v1/revenue/merchants?quantity=1'

    expect(json_data.length).to eq(1)
  end
  
  context 'if quantity is greater than total count' do
    it 'will return all possible' do
      get '/api/v1/revenue/merchants?quantity=9'

      expect(json_data.length).to eq(5)
    end
  end

  context 'with invalid params' do
    it 'returns 400 error for missing quantity param' do
      get '/api/v1/revenue/merchants'

      expect(response).to have_http_status(:bad_request)
      expect(json_body[:error]).to eq('bad or missing param')
    end
    
    it 'returns 400 error for missing quantity value' do
      get '/api/v1/revenue/merchants?quantity='

      expect(response).to have_http_status(:bad_request)
      expect(json_body[:error]).to eq('bad or missing param')
    end
    
    it 'returns 400 error for a non-integer quantity value' do
      get '/api/v1/revenue/merchants?quantity=F00bAr'

      expect(response).to have_http_status(:bad_request)
      expect(json_body[:error]).to eq('bad or missing param')
    end
  end

end
