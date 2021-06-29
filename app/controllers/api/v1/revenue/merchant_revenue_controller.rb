class Api::V1::Revenue::MerchantRevenueController < ApplicationController

  def index
    # binding.pry
    merchants = Merchant.most_revenue(params[:quantity].to_i)
    render json: MerchantMostRevenueSerializer.new(merchants)
  end

end