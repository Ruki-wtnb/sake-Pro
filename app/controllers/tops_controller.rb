class TopsController < ApplicationController
  
  def index
    
      @tops = Jsake.paginate(page: params[:page], per_page: 28)
      
      @search = SearchHistory.new
      #binding.pry
    
  end
  
  def result
    @result = session[:search_result]
    @result2 = session[:search]
  end
  
  def search
    redirect_to root_path if params_word[:word] == "" #検索ワードが空ならトップページ
    
    split_word = params_word[:word].split(/[[:blank:]]+/) #検索ワードを空白で分割する
    
    result = [] #検索結果用の配列
    
    split_word.each do |word|
      key_word = Jsake.where('meigara LIKE(?)', "%#{word}%") #Jsakeから検索
      words = key_word.pluck(:id, :user_id, :image_url, :meigara, :seimai_buai, :locaility, :alcohol_degree, :sake_meter_value, :acidity)
      next if words == ""
        words.each do |w|
          result.push({id: w[0], user_id: w[1],image_url: w[2], meigara: w[3], seimai_buai: w[4], locaility: w[5], alcohol_degree: w[6], sake_meter_value: w[7], acidity: w[8]})
        end
    end
    result2 = []
    split_word.each do |word2|
      key_word = Jsake.where('meigara LIKE(?)', "%#{word2}%") #Jsakeから検索
      next if key_word == ""
      result2.push(key_word)
    end
    
    #binding.pry
    
    search_result result
    test result2
    
    redirect_to action: 'result'
  
    
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
  
  def search_result(result)
    session[:search_result] = result
  end
  
  def test(result2)
    session[:search] = result2
  end
  
end
