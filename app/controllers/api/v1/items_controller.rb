class Api::V1::ItemsController < ApplicationController

  def index
    items = Item.paginate(page: what_page, per_page: per_page_count)
    render json: serializer.new(items)
  end

  def serializer
    ItemSerializer
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
