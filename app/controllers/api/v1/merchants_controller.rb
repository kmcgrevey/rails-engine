class Api::V1::MerchantsController < ApplicationController

  def show
    merchant = Merchant.find(params[:id])
    render json: serializer.new(merchant)
  end

  def serializer
    MerchantSerializer
  end

end
