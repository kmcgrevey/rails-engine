class Api::V1::Revenue::MerchantRevenueController < ApplicationController

  def index
    if !params[:quantity] || (params[:quantity].to_i <= 0)
      render json: {error: 'bad or missing param'}, status: 400
    else
      merchants = Merchant.most_revenue(params[:quantity].to_i)
      render json: MerchantMostRevenueSerializer.new(merchants)
    end
  end

end