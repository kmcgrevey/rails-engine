class Invoice < ApplicationRecord
  belongs_to :merchant
  belongs_to :customer
  has_many :invoice_items
  has_many :transactions

  def self.potential_rev
    joins(:invoice_items)
    .where(invoices: { status: 'packaged' })
    .select('SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
    .group(:id)
  end
end
