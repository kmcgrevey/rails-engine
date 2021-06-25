class Api::V1::Items::ItemSearcherController < ApplicationController

  def show
    if params[:name]
      item = Item.where('lower(name) LIKE ?', "%#{params[:name].downcase}%")
                 .order(:name)
                 .first
    end
    if params[:min_price]
      item = Item.where('unit_price >= ?', params[:min_price].to_i)
                 .order(:name)
                 .first
    end
    if params[:max_price]
      item = Item.where('unit_price <= ?', params[:max_price].to_i)
                 .order(:name)
                 .first
    end

    if item
      render json: serializer.new(item)
    end
  end

  def serializer
    ItemSerializer
  end

end