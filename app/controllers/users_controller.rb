class UsersController < ApplicationController

 def new
  @user = User.new
  @name_value = "15文字以内"
 end

 def create
  @user = User.new(user_params)
  if @user.save
   redirect_to login_path, success: '登録が完了しました'
  else
   flash.now[:danger] = '登録に失敗しました'
  render :new
  end
 end
  
 def edit
  @user = User.find(current_user.id)
 end
  
 def update
  user = User.find(params[:id])
  user.update!(user_params)
  redirect_to mypage_path, success: "ユーザ情報を修正しました" 
 end
  
 private
  def user_params
   params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
end