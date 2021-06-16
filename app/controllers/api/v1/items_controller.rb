class Api::V1::ItemsController < ApplicationController

  def index
    items = Item.paginate(page: what_page, per_page: per_page_count)
    render json: serializer.new(items)
  end

  def serializer
    ItemSerializer
  end

end
