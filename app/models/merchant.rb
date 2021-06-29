class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  def self.name_finder(name)
    where('lower(name) LIKE ?', "%#{name.downcase}%")
    .order(:name)
  end

  def self.most_revenue(quantity)
    select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS rev_total')
    .joins(:invoice_items, :transactions)
    .merge(Transaction.successful)
    .group(:id)
    .order('rev_total DESC')
    .limit(quantity)
  end

end
