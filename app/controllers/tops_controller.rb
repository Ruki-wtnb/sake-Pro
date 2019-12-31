class TopsController < ApplicationController
  
  def index #トップページでの日本酒一覧表示
      @tops = Jsake.paginate(page: params[:page], per_page: 28)
      @search = SearchHistory.new
      
      if current_user != nil
        @search_history = SearchHistory.where(user_id: current_user.id)
      end
      
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
    
    @search = SearchHistory.new
    if current_user != nil
      @search_history = SearchHistory.where(user_id: current_user.id)
      search_history_save
    end
    
    render :result

  end
  
  def result #検索履歴を表示
  end
  
  def search_history_save #検索履歴の保存
    @search = SearchHistory.new
    @search.user_id = current_user.id
    @search.word = params_word[:word]
    
    check = SearchHistory.where(user_id: current_user.id)
    word = SearchHistory.where(user_id: current_user.id, word: @search.word)
    
    if check.count >= 5 && word.empty?
      check.limit(1).delete_all
      @search.save
    end

  end
  
  private
  def params_word
    params.require(:search_history).permit(:word)
  end

  
end
