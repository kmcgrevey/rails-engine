class Invoice < ApplicationRecord
  belongs_to :merchant
  belongs_to :customer
  has_many :invoice_items
  has_many :transactions

  def self.potential_rev(quantity = 10)
    joins(:invoice_items)
    .where(invoices: { status: 'packaged' })
    .select(:id, 'SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
    .group(:id)
    .order('revenue desc')
    .limit(quantity)
  end

end
