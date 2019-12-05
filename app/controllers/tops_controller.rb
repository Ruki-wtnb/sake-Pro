class TopsController < ApplicationController
  def index
    @search = SearchHistory.new 
    @tops = Jsake.paginate(page: params[:page], per_page: 28)
  end
  
  def search
  end
  
end
