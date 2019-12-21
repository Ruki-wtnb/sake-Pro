class TopsController < ApplicationController
  
  def index
      @tops = Jsake.paginate(page: params[:page], per_page: 28)
      @search = SearchHistory.new
      #binding.pry
  end
  
  def result #検索結果を表示
    @result = session[:search_result].uniq.paginate(page: params[:page], per_page: 28)
    @search = SearchHistory.new
  end
  
  def search #自作の検索メソッド
    redirect_to root_path if params_word[:word] == "" #検索ワードが空ならトップページ
    
    split_word = params_word[:word].split(/[[:blank:]]+/) #検索ワードを空白で分割する
    
    @result = [] #検索結果用の配列
    
    split_word.each do |word| #split_wordで検索をかけて、検索結果を配列push
      key_word = Jsake.where('meigara LIKE(?)', "%#{word}%") #Jsakeから検索
      next if key_word == ""
      key_word.each do |key|
        @result.push(key)
      end
    end

   
    
    search_history_save

    #binding.pry
    
    render :result

  end
  
  def r #ransackでの実装
  
    params[:q]['meigara_cont_any'] = params[:q]['meigara_cont_any'].split(/[[:blank:]]+/)
    @ran_search = Jsake.ransack(params[:q])
    @ran_result = @ran_search.result
    #binding.pry
    
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
