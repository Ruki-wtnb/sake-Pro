class MypagesController < ApplicationController
  
  def index
    @my_sake = Jsake.paginate(page: params[:page], per_page: 28)
    @mypages = @my_sake.where(user_id: current_user.id)
    @plot = @mypages.pluck(:sake_meter_value, :acidity)
  end
  
  def create
    favorite = Favorite.new
    favorite.user_id = current_user.id
    favorite.jsake_id = params[:jsake_id]
  end
  
end