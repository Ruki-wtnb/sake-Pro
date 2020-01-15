class JsakesController < ApplicationController
  def new
    @jsake = Jsake.new

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
  
  def edit
    @update_id = params[:id]
    @jsake = Jsake.find(@update_id)
  end
  
  def update

    @jsake = Jsake.find(params[:id])
    
    if @jsake.update(jsake_params)
      redirect_to controller: 'mypages', action: 'index', success: '銘柄を修正しました'
    else
      flash.now[:danger] = '銘柄の修正に失敗しました。入力内容を確認してください。'
      render :edit
    end
    #binding.pry
    
  end
  
  
  private
  def jsake_params
    params.require(:jsake).permit(:image_url, :meigara, :seimai_buai, :locaility, :alcohol_degree, :sake_meter_value, :acidity, :image)
  end
  
  
end
