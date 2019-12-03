class JsakesController < ApplicationController
  def new
    @jsake = Jsake.new
    #@prefecture = Prefecture.all
    #@seimaibuai = Seimaibuai.all
  end
  
  def create
    @jsake = Jsake.new(jsake_params)
    @jsake.user_id = current_user.id
    #binding.pry
    if @jsake.save!
      redirect_to root_path, success: '銘柄を登録しました。ご協力ありがとうございます！'
    else
      flash.now[:danger] = '登録に失敗しました。入力内容を確認してください。'
      render :new
    end
  end
  
  private
  def jsake_params
    params.require(:jsake).permit(:image_url, :meigara, :seimai_buai, :locaility, :alcohol_degree, :sake_meter_value, :acidity)
  end
  
  
  
end
