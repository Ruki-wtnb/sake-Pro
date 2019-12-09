class MypagesController < ApplicationController
  
  def index
    @mypages = current_user.jsakes.paginate(page: params[:page], per_page: 28)
    @favorite_jsakes = current_user.favorite_jsakes
    @plot = @mypages.pluck(:sake_meter_value, :acidity)
    
    #binding.pry
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