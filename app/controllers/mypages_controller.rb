class MypagesController < ApplicationController
  
  def index
    @mypages = current_user.jsakes.paginate(page: params[:page], per_page: 28)
    @sakes = @mypages.pluck(:meigara, :sake_meter_value, :acidity)
    
    @favorite_jsakes = current_user.favorite_jsakes.paginate(page: params[:page], per_page: 28)
    @favo_sake = @favorite_jsakes.pluck(:meigara, :sake_meter_value, :acidity)
    #binding.pry
    p = []

    @favo_sake.each do |sake|
      p.push({meigara: sake[0], xy: [sake[1], sake[2]]})
    end
    
    @plot = []
    p.each do |pl|
      @plot.push({name: [pl[:meigara]], data: [pl[:xy]]})
    end
    
    
    
  end
  
  def create #いいねの作成
    favorite = Favorite.new
    favorite.user_id = current_user.id
    favorite.jsake_id = params[:jsake_id]
    
    if favorite.save
      flash.now[:success] = 'いいねしました'
      index
      render :index
    else
      flash.now[:danger] = 'いいねに失敗しました'
      index
      render :index
    end
    
  end
  
  def destroy #いいねの削除
    #binding.pry
    unfavorite = Favorite.find_by(user_id: current_user.id, jsake_id: params[:jsake_id].to_i) #レコードの検索
    
    if unfavorite.destroy
      flash.now[:success] = 'いいねを削除しました'
      index
      render :index
    else
      flash.now[:danger] = 'いいねの削除に失敗しました'
      index
      render :index
    end
  end

  
end