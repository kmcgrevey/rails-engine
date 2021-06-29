require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "#relationships" do
    it { should have_many(:items) }
    it { should have_many(:invoices) }
    it { should have_many(:invoice_items).through(:invoices) }
  end

  describe 'class methods' do
    before (:each) do
      inv_items = create_list(:invoice_item, 5)
      inv_items.each { |item| item.invoice.transactions.create(result: 'success') }
    end

    it '.most_revenue' do
      top_one = Merchant.most_revenue(1)
      top_two = Merchant.most_revenue(2)
      top_four = Merchant.most_revenue(4)

      expect(top_one[1]).to eq(nil)
      expect(top_two[0]).to eq(top_one[0])
      expect(top_four[0]).to eq(top_one[0])
      expect(top_four[1]).to eq(top_two[1])
      expect(top_four[4]).to eq(nil)
    end
  end

end
