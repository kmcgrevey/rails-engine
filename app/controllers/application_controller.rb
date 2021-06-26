class ApplicationController < ActionController::API
  include PageCleaner

  def validate_name
    if params.keys.sort == ["name", "min_price", "controller", "action"].sort ||
      params.keys.sort == ["name", "max_price", "controller", "action"].sort ||
      params.keys.sort == ["name", "max_price", "min_price", "controller", "action"].sort

      render status: 400 and return
    end
  end
end
