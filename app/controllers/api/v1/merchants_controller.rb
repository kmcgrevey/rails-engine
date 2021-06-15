class Api::V1::MerchantsController < ApplicationController

  def show
    merchant = Merchant.find(params[:id])
    render json: serializer.new(merchant)
  end

  def index
    merchants = Merchant.paginate(page: what_page, per_page: per_page_count)
    render json: serializer.new(merchants)
  end

  def serializer
    MerchantSerializer
  end

  def what_page
    begin 
      WillPaginate::PageNumber(params[:page])
    rescue WillPaginate::InvalidPage
      1  
    end 
  end

  def per_page_count
    !params[:per_page] ? 20 : params[:per_page]
  end

end
