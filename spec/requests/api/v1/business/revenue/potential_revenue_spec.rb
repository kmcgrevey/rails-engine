require 'rails_helper'

RSpec.describe 'Potential Revenue endpoint', type: :request do
  before (:each) do
    merch1 = create(:merchant)
    merch2 = create(:merchant)

    item1 = create(:item, merchant_id: merch1.id, unit_price: 2.00)
    item2 = create(:item, merchant_id: merch2.id, unit_price: 200.00)
    
    inv1_m1 = create(:invoice, merchant_id: merch1.id, status: 'packaged')
    inv2_m1 = create(:invoice, merchant_id: merch1.id, status: 'shipped')
    @inv3_m2 = create(:invoice, merchant_id: merch2.id, status: 'packaged')
    inv4_m2 = create(:invoice, merchant_id: merch2.id, status: 'returned')

    invitem1 = create(:invoice_item, invoice_id: inv1_m1.id, item_id: item1.id, quantity: 5, unit_price: 2.00)
    invitem2 = create(:invoice_item, invoice_id: inv2_m1.id, item_id: item1.id, quantity: 1, unit_price: 2.00)
    invitem3 = create(:invoice_item, invoice_id: @inv3_m2.id, item_id: item2.id, quantity: 5, unit_price: 200.00)
    invitem4 = create(:invoice_item, invoice_id: inv4_m2.id, item_id: item1.id, quantity: 1, unit_price: 200.00)
  end

  subject { get '/api/v1/revenue/unshipped?quantity=5' }

  it 'returns a successful response' do
    subject
    expect(response).to be_successful
  end

  it 'returns a proper JSON response in order' do
    subject

    expect(json_data.length).to eq(2)
    expect(json_data.first[:id]).to eq(@inv3_m2.id.to_s)
    expect(json_data.first[:type]).to eq('unshipped_order')
    expect(json_data.first[:attributes][:potential_revenue].class).to eq(Float)
  end

end