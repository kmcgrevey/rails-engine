class Api::V1::Revenue::MerchantRevenueController < ApplicationController
  before_action :check_merchant, only: [:show]
  
  def index
    if !params[:quantity] || (params[:quantity].to_i <= 0)
      render json: {error: 'bad or missing param'}, status: 400
    else
      merchants = Merchant.most_revenue(params[:quantity].to_i)
      render json: MerchantMostRevenueSerializer.new(merchants)
    end
  end

  def show
    revenue = Merchant.revenue(params[:id])
    render json: MerchantRevenueSerializer.new(params[:id], revenue).serialize
  end

  private

  def check_merchant
    Merchant.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render status: 404
  end

end
