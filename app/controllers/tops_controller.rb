class TopsController < ApplicationController
  def index
    @tops = Jsake.paginate(page: params[:page], per_page: 28)
    @search = SearchHistory.new
  end
  
  def search
    key_word = params_word[:word]
    binding.pry
    search_history_save
    
  end
  
  def search_history_save
    @search = SearchHistory.new
    @search.user_id = current_user.id
    @search.word = params_word[:word]
  end
  
  private
  def params_word
    params.require(:search_history).permit(:word)
  end
  
end
