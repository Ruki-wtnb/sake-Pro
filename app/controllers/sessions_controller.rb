class SessionsController < ApplicationController
  #log_inメソッドをビューでも呼び出せるようにする
  helper_method :log_in
  #view/session/new.html.erbを呼び出す
  def new
  end
  
  def create
    #Userモデルからemailをキーに、入を力されたemailを検索する
    user = User.find_by(email: user_info[:email])
    #登録されたemailであり、暗号化されたパスワードが一致するか
    if user && user.authenticate(user_info[:password])
      log_in(user)
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to mypage_path, success: 'ログインに成功しました'
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end
  #applicationコントローラのlogged_in?メソッドがnilでないなら
  #ログアウトする。
  def destroy
    log_out if logged_in?
    redirect_to root_path, info: 'ログアウトしました'
  end
  
  private
  #userオブジェクトを引数に取り、セッションへuser_idを保存する
  def log_in(user)
    session[:user_id] = user.id
  end
  #クッキーに保存する
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
  #クッキー情報を削除する
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
  #セッション情報を削除する
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
  #user情報として:email, :password, :remember_meを取得する
  def user_info
    params.require(:session).permit(:email, :password, :remember_me)
  end
  
end
