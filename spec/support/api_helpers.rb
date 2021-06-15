module ApiHelpers

  def json_body
    JSON.parse(response.body, symbolize_names: true )
  end
  
  def json_data
    JSON.parse(response.body, symbolize_names: true )[:data]
  end

end