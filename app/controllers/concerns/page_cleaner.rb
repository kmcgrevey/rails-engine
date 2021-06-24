module PageCleaner
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
