class Api::V1::ItemsController < ApplicationController

  def index
    items = Item.paginate(page: what_page, per_page: per_page_count)
    render json: serializer.new(items)
  end
  
  def show
    item = Item.find(params[:id])
    render json: serializer.new(item)
  end

  def create
    item = Item.create(item_params)
    if item.save
      render json: serializer.new(item)
    end
  end

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      render json: serializer.new(item)
    end
  end
  
  def destroy
    item = Item.find(params[:id])
    item.destroy
  end

  def serializer
    ItemSerializer
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end

end
