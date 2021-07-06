class PotentialRevenueSerializer
  include JSONAPI::Serializer

  set_type :unshipped_order
  attribute :potential_revenue do |invoice|
    invoice.revenue
  end

end