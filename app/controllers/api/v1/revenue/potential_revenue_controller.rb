class Api::V1::Revenue::PotentialRevenueController < ApplicationController

  def index
    potential = Invoice.potential_rev(params[:quantity])
    render json: PotentialRevenueSerializer.new(potential)
  end

end
