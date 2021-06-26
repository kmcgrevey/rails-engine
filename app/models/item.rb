class Item < ApplicationRecord
  belongs_to :merchant

  def self.name_finder(name)
    where('lower(name) LIKE ?', "%#{name.downcase}%")
    .order(:name)
  end

  def self.min_price_finder(price)
    where('unit_price >= ?', price.to_f)
    .order(:name)
  end


end
