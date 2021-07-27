class UsersController < ApplicationController

#Userモデルを新規作成id: nil,
#name, email, password_digest, created_at, updated_at, remember_digest
#をフィールドに持つオブジェクトを作成
 def new
  @user = User.new
  @name_value = "15文字以内"
 end
#ユーザ新規登録の登録ボタンからcreateアクションへ
 def create
  @user = User.new(user_params)
  if @user.save
    UserMailer.account_activation(@user).deliver_now
    flash[:info] = "Please check your email to activate your account."
   #ログイン画面へリダイレクトする
   redirect_to login_path, success: '登録が完了しました'
  else
   flash.now[:danger] = '登録に失敗しました'
  #新規登録画面に再び戻る
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
   params.require(:user).permit(:name, :email, :gender_id, :birthday, :password, :password_confirmation)
  end
  
end