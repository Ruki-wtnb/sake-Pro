class MypagesController < ApplicationController
 
 def index

  if current_user.id == 1
    @mypages = Jsake.paginate(page: params[:page], per_page: 28)
  else
    @mypages = current_user.jsakes.order(id: "DESC").paginate(page: params[:page], per_page: 28)
  end

  @sakes = @mypages.pluck(:meigara, :sake_meter_value, :acidity)
  @favorite_jsakes = current_user.favorite_jsakes.paginate(page: params[:page], per_page: 28)
  @favo_sake = @favorite_jsakes.pluck(:meigara, :sake_meter_value, :acidity)

  @chart, @x, @y, @color = TopsController.get_data(@favo_sake)

 end
  
 def create #いいねの作成
  @sake = Jsake.find(params[:jsake_id])
  favorite = Favorite.new
  favorite.user_id = current_user.id
  favorite.jsake_id = params[:jsake_id]
  favorite.save
 end

 def destroy #いいねの削除
  @sake = Jsake.find(params[:jsake_id])
  unfavorite = Favorite.find_by(user_id: current_user.id, jsake_id: params[:jsake_id].to_i) #レコードの検索
  unfavorite.destroy
 end
 
end