class MerchantRevenueSerializer

  def initialize(id, revenue)
    @id = id
    @revenue = revenue
  end

  def serialize
    {
      data: {
        id: @id,
        type: "merchant_revenue",
        attributes: {
          revenue: @revenue
        }
      }
    }
  end
end
