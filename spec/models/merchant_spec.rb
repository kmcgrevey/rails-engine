require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "#relationships" do
    it { should have_many(:items) }
    it { should have_many(:invoices) }
    it { should have_many(:invoice_items).through(:invoices) }
  end

  describe 'class methods' do
    it '.most_revenue' do
      inv_items = create_list(:invoice_item, 5)
      inv_items.each { |item| item.invoice.transactions.create(result: 'success') }

      top_one = Merchant.most_revenue(1)
      top_two = Merchant.most_revenue(2)
      top_four = Merchant.most_revenue(4)

      expect(top_one[1]).to eq(nil)
      expect(top_two[0]).to eq(top_one[0])
      expect(top_four[0]).to eq(top_one[0])
      expect(top_four[1]).to eq(top_two[1])
      expect(top_four[4]).to eq(nil)
    end

    it '.revenue' do
      merch1 = create(:merchant)
      merch2 = create(:merchant)
  
      item1 = create(:item, merchant_id: merch1.id, unit_price: 2.00)
      item2 = create(:item, merchant_id: merch2.id, unit_price: 200.00)
     
      inv1_m1 = create(:invoice, merchant_id: merch1.id, status: 'shipped')
      inv2_m1 = create(:invoice, merchant_id: merch1.id, status: 'shipped')
      inv3_m1 = create(:invoice, merchant_id: merch1.id, status: 'packaged')
      inv4_m1 = create(:invoice, merchant_id: merch1.id, status: 'returned')
      inv5_m2 = create(:invoice, merchant_id: merch2.id, status: 'shipped')
 
      invitem1 = create(:invoice_item, invoice_id: inv1_m1.id, item_id: item1.id, quantity: 5, unit_price: 2.00)
      invitem2 = create(:invoice_item, invoice_id: inv2_m1.id, item_id: item1.id, quantity: 5, unit_price: 2.00)
      invitem3 = create(:invoice_item, invoice_id: inv3_m1.id, item_id: item1.id, quantity: 5, unit_price: 2.00)
      invitem4 = create(:invoice_item, invoice_id: inv4_m1.id, item_id: item1.id, quantity: 5, unit_price: 2.00)
      invitem5 = create(:invoice_item, invoice_id: inv5_m2.id, item_id: item2.id, quantity: 5, unit_price: 200.00)

      trxn1 = create(:transaction, invoice_id: inv1_m1.id, result: 'success')
      trxn2 = create(:transaction, invoice_id: inv2_m1.id, result: 'success')
      trxn3 = create(:transaction, invoice_id: inv3_m1.id, result: 'failed')
      trxn4 = create(:transaction, invoice_id: inv4_m1.id, result: 'success')
      trxn5 = create(:transaction, invoice_id: inv5_m2.id, result: 'success')
 

      rev1 = Merchant.revenue(merch1.id)
      rev2 = Merchant.revenue(merch2.id)

      expect(rev1).to eq(20.00)
      expect(rev2).to eq(1000.00)
    end
  end

end
