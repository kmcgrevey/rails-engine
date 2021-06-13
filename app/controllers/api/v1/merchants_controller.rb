class Api::V1::MerchantsController < ApplicationController

  def show
    merchant = Merchant.find(params[:id])
    render json: serializer.new(merchant)
  end

  def index
    # merchants = Merchant.paginate(page: params[:page], per_page: 20)
    merchants = Merchant.paginate(page: what_page, per_page: per_page_count)
    render json: serializer.new(merchants)
  end

  def serializer
    MerchantSerializer
  end

  def what_page
    if !params[:page] || params[:page] == 0
      1
    else
      params[:page]
    end
  end

  def per_page_count
    if !params[:per_page]
      20
    else
      params[:per_page]
    end
  end

end
