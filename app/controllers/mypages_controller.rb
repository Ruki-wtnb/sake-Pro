class MypagesController < ApplicationController
 
 def index
  @mypages = current_user.jsakes.paginate(page: params[:page], per_page: 28)
  @sakes = @mypages.pluck(:meigara, :sake_meter_value, :acidity)
  @favorite_jsakes = current_user.favorite_jsakes.paginate(page: params[:page], per_page: 28)
  @favo_sake = @favorite_jsakes.pluck(:meigara, :sake_meter_value, :acidity)
  #@plot = []
  
  #@favo_sake.each do |sake|
   #@plot.push({name: sake[0], data: [[sake[1], sake[2]]]})
  #end

  @chart = ''
  @x = []
  @y = []
  @favo_sake.each_with_index do |sake, i|
    @chart += sake[0]
    if @favo_sake.size-1 != i
      @chart += ','
    end
    @x.push(sake[1])
    @y.push(sake[2])
  end



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
