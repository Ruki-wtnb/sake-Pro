class MypagesController < ApplicationController
  
  def index
    @my_sake = Jsake.paginate(page: params[:page], per_page: 28)
    @mypages = @my_sake.where(user_id: current_user.id)
    @favorite_sakes = current_user.favorite_jsakes
    @plot = @mypages.pluck(:sake_meter_value, :acidity)
  end
  
  def create
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
end