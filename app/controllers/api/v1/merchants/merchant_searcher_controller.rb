class Api::V1::Merchants::MerchantSearcherController < ApplicationController

  def show
    if params[:name]
      merchant = Merchant.name_finder(params[:name]).first
    end

    if merchant
      render json: serializer.new(merchant)
    else
      render json: {"data": {}}, status: 200
    end


  end

  def serializer
    MerchantSerializer
  end

end