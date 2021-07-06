require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "#relationships" do
    it { should belong_to(:merchant) }
    it { should belong_to(:customer) }
    it { should have_many(:invoice_items) }
    it { should have_many(:transactions) }
  end

  describe 'class methods' do
    it '.potential_rev' do
      merch1 = create(:merchant)
      merch2 = create(:merchant)
  
      item1 = create(:item, merchant_id: merch1.id, unit_price: 2.00)
      item2 = create(:item, merchant_id: merch2.id, unit_price: 200.00)
     
      inv1_m1 = create(:invoice, merchant_id: merch1.id, status: 'packaged')
      inv2_m1 = create(:invoice, merchant_id: merch1.id, status: 'shipped')
      inv3_m2 = create(:invoice, merchant_id: merch2.id, status: 'packaged')
      inv4_m2 = create(:invoice, merchant_id: merch2.id, status: 'returned')
 
      invitem1 = create(:invoice_item, invoice_id: inv1_m1.id, item_id: item1.id, quantity: 5, unit_price: 2.00)
      invitem2 = create(:invoice_item, invoice_id: inv2_m1.id, item_id: item1.id, quantity: 1, unit_price: 2.00)
      invitem3 = create(:invoice_item, invoice_id: inv3_m2.id, item_id: item2.id, quantity: 5, unit_price: 200.00)
      invitem4 = create(:invoice_item, invoice_id: inv4_m2.id, item_id: item1.id, quantity: 1, unit_price: 200.00)
 
      potential = Invoice.potential_rev

      expect(potential.length).to eq(2)
      expect(potential.first.revenue).to eq(1000.00)
      expect(potential.last.revenue).to eq(10.00)
    end
  end

end