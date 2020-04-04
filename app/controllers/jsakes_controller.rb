class JsakesController < ApplicationController
 def new
  @jsake = Jsake.new
 end
  
 def create
  amakara_calculation
  @jsake = Jsake.new(jsake_params)
  @jsake.user_id = current_user.id
  @jsake.amakara = amakara_calculation
  #binding.pry
  if @jsake.save!
   redirect_to root_path, success: '銘柄を登録しました。ご協力ありがとうございます！'
  else
   flash.now[:danger] = '登録に失敗しました。入力内容を確認してください。'
   render :new
  end
 end

 def edit
  @update_id = params[:id]
  @jsake = Jsake.find(@update_id)
 end
  
 def update
  @jsake = Jsake.find(params[:id])
  @jsake.amakara = amakara_calculation
  if @jsake.update(jsake_params)
   redirect_to controller: 'mypages', action: 'index', success: '銘柄を修正しました'
  else
   flash.now[:danger] = '銘柄の修正に失敗しました。入力内容を確認してください。'
   render :edit
  end
 end
  
private
 def amakara_calculation
  sakeMeterValue = params[:jsake][:sake_meter_value].to_f
  acidity = params[:jsake][:acidity].to_f
  sakeMeterValuePart = 193593 / (1443 + sakeMeterValue)
  acidityPart = -1.16 * acidity
  amakaraValue = (sakeMeterValuePart + acidityPart) -132.57
  if amakaraValue == 0
   return "どちらでもない"
  elsif 0 < amakaraValue && amakaraValue <= 1
   return "少し甘い"
  elsif 1 < amakaraValue && amakaraValue <= 2
   return "かなり甘い"
  elsif 2 < amakaraValue
   return "非常に甘い"
  elsif -1 <= amakaraValue && amakaraValue < 0
   return "少し辛い"
  elsif -2 <= amakaraValue && amakaraValue < -1
   return "かなり辛い"
  elsif amakaraValue < -2
   return "非常に辛い"
  end
 end

 def jsake_params
  params.require(:jsake).permit(:image_url, :meigara, :seimai_buai, :locaility, :alcohol_degree, :sake_meter_value, :acidity, :image)
 end
 
end
