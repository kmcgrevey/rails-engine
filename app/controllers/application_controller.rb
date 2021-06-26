class ApplicationController < ActionController::API
  include PageCleaner

  def validate_name
    if params.keys.sort == ["name", "min_price", "controller", "action"].sort ||
      params.keys.sort == ["name", "max_price", "controller", "action"].sort ||
      params.keys.sort == ["name", "max_price", "min_price", "controller", "action"].sort

      render status: 400 and return
    end
  end

  def validate_price
    if params[:min_price].to_f < 0

      render status: 400 and return
    end
  end
end
