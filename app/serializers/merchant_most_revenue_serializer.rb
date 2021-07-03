class MerchantMostRevenueSerializer
  include JSONAPI::Serializer

  set_type :merchant_name_revenue
  attribute :name
  attribute :revenue do |merchant|
    merchant.rev_total
  end

end