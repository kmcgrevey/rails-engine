class Api::V1::Items::ItemSearcherController < ApplicationController

  def show
    if params[:name]
      item = Item.where('lower(name) LIKE ?', "%#{params[:name].downcase}%")
                 .order(:name)
                 .first
    end

    render json: serializer.new(item)
  end

  def serializer
    ItemSerializer
  end

end