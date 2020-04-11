class SessionsController < ApplicationController
  
  helper_method :log_in
  
  def new
  end
  
  def create
    user = User.find_by(email: user_info[:email])

    if user && user.authenticate(user_info[:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to mypage_path, success: 'ログインに成功しました'
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end
  
  def destroy
    log_out if logged_in?
    redirect_to root_path, info: 'ログアウトしました'
  end
  
  private
  def log_in(user) #sessionメソッドでuse.idを保存している
    session[:user_id] = user.id
  end
  
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
  
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
  
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
  
  def user_info
    params.require(:session).permit(:email, :password, :remember_me)
  end
  
  
end
