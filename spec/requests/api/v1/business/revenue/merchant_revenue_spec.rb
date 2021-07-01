require 'rails_helper'

RSpec.describe 'Merchant Revenue endpoint', type: :request do
  before (:each) do
    @merchant = create(:merchant)
    item = create(:item, merchant: @merchant)
    invoice = create(:invoice, merchant: @merchant)
    @inv_item = create(:invoice_item, item: item, invoice: invoice)
    trxn = create(:transaction, invoice: invoice) 
  end

  subject { get "/api/v1/revenue/merchants/#{@merchant.id}"}

  it 'returns a successful response' do
    subject
    expect(response).to be_successful
  end

  it 'returns a proper JSON response' do
    subject

    expect(json_data[:type]).to eq('merchant_revenue')
    expect(json_data[:attributes]).to have_key(:revenue)
  end

  it 'calculates the revenue' do
    subject
    rev = @inv_item.quantity * @inv_item.unit_price

    expect(json_data[:attributes][:revenue]).to eq(rev)
  end

end