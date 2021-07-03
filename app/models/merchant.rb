class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices

  def self.name_finder(name)
    where('lower(name) LIKE ?', "%#{name.downcase}%")
    .order(:name)
  end

  def self.most_revenue(quantity)
    joins(invoices: [:invoice_items, :transactions])
    .where(transactions: { result: 'success' })
    .where(invoices: { status: 'shipped' })
    .select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS rev_total')
    .group(:id)
    .order('rev_total DESC')
    .limit(quantity)
  end

  def self.revenue(id)
    joins(invoices: [:invoice_items, :transactions])
    .where(transactions: { result: 'success' })
    .where(invoices: { status: 'shipped' })
    .where(merchants: { id: id })
    .select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS rev_total')
    .group(:id)
    .first
    .rev_total
  end

end
