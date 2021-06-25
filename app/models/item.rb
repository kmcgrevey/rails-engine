class Item < ApplicationRecord
  belongs_to :merchant

  def self.name_finder(name)
    where('lower(name) LIKE ?', "%#{name.downcase}%")
    .order(:name)
  end

end
