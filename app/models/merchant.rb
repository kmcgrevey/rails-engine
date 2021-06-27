class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices

  def self.name_finder(name)
    where('lower(name) LIKE ?', "%#{name.downcase}%")
    .order(:name)
  end

end
