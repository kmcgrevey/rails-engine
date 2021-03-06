class Api::V1::Items::ItemSearcherController < ApplicationController
  before_action :validate_name, only: [:show]
  before_action :validate_price, only: [:show]

  def show
    if params[:name]
      item = Item.name_finder(params[:name]).first
    elsif params[:max_price] && params[:min_price]
      item = Item.where('unit_price >= ? AND unit_price <=?', params[:min_price].to_f, params[:max_price])
                 .order(:name)
                 .first
    elsif params[:min_price]
      item = Item.min_price_finder(params[:min_price]).first
    elsif params[:max_price]
      item = Item.where('unit_price <= ?', params[:max_price].to_f)
                 .order(:name)
                 .first
    end

    if item
      render json: serializer.new(item)
    else
      render json: {"data": {}}, status: 200
    end
  end

  def index
    if params[:name]
      items = Item.name_finder(params[:name])
    elsif params[:min_price]
      items = Item.min_price_finder(params[:min_price])
    end

    if items
      render json: serializer.new(items)
    else
      render json: {"data": []}, status: 200
    end
  end

  def serializer
    ItemSerializer
  end

end