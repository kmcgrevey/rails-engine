class Merchant < ApplicationRecord
  has_many :items

  def self.name_finder(name)
    where('lower(name) LIKE ?', "%#{name.downcase}%")
    .order(:name)
  end

end
