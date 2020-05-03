class TopsController < ApplicationController
  def index #トップページでの日本酒一覧表示
    @tops = Jsake.order(id: "DESC").paginate(page: params[:page], per_page: 28)
    @search = SearchHistory.new
    
    if current_user != nil
      @search_history = SearchHistory.where(user_id: current_user.id)
    end
  end
 
  def search #検索用アクション
    split_word = params_word[:word].split(/[[:blank:]]+/) #検索ワードを空白(半角or全角)で分割する
    @result = [].paginate(page: params[:page], per_page: 28) #検索結果格納用の配列
      
    split_word.each do |word| #split_wordで検索をかけて、検索結果を配列push
      single_key_word = Jsake.where('meigara LIKE(?)', "%#{word}%") #日本酒テーブルからwordで検索
      next if single_key_word == ""
        single_key_word.each do |key|
          @result.push(key)
        end
      end
      @search_sake = @result.pluck(:meigara, :sake_meter_value, :acidity)
      @search_plot = []
      @search_sake.each do |sake|
      @search_plot.push({name: sake[0], data: [[sake[1], sake[2]]]})
    end
          
    @search = SearchHistory.new #検索履歴モデルの新規
    if current_user != nil #ログインしているならば検索履歴の表示と保存を実行
      @search_history = SearchHistory.where(user_id: current_user.id)
      search_history_save
    end
      
    if params_word[:word] == ""
      redirect_to root_path
    else
      render :result
    end
  end
  
 def result #検索履歴を表示
 end
  
 def search_history_save #検索履歴の保存
  @search_save = SearchHistory.new
  @search_save.user_id = current_user.id
  @search_save.word = params_word[:word]
  
  check = SearchHistory.where(user_id: current_user.id) #検索履歴の数用
  word = SearchHistory.where(user_id: current_user.id, word: @search_save.word) #過去に同じワードで検索しているか
      
  if check.count >= 5 && word.empty? #検索数が5件以上で、同じワードで検索していないならば
   check.limit(1).delete_all #一番古い履歴を一件削除
   @search_save.save #検索履歴を保存
  elsif check.count < 5
   @search_save.save
  end
 end
  
 private #検索ワードのみを受け付ける
  def params_word
   params.require(:search_history).permit(:word)
  end

end
