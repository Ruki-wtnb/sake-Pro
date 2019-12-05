class TopsController < ApplicationController
  def index
    @tops = Jsake.paginate(page: params[:page], per_page: 28)
  end
  
  def search
    binding.pry
  end
  
end
