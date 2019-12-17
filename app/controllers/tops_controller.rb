class TopsController < ApplicationController
  
  def index
    session.delete(:search_result)
      @tops = Jsake.paginate(page: params[:page], per_page: 28)
      @result = session[:search_result]
      @search = SearchHistory.new
    
  end
  
  def search
    redirect_to root_path if params_word[:word] == "" #検索ワードが空ならトップページ
    
    split_word = params_word[:word].split(/[[:blank:]]+/) #検索ワードを空白で分割する
    
    result = [] #検索結果用の配列
    
    split_word.each do |word|
      key_word = Jsake.where('meigara LIKE(?)', "%#{word}%").split(",") #Jsakeから検索
      next if key_word == ""
      result.push(key_word)
    end
    
    results = result.paginate(page: params[:page], per_page: 28)
    search_result results
    
    binding.pry
    
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
  
  def search_result(results)
    session[:search_result] = results
  end
  
end
