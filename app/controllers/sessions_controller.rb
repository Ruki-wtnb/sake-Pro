class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: user_info[:email])

    if user && user.authenticate(user_info[:password])
      log_in user
      redirect_to new_jsake_path, success: 'ログインに成功しました'
      #binding.pry
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end
  
  def destroy
    log_out
    redirect_to root_path, info: 'ログアウトしました'
  end
  
  private
  def log_in(user) #sessionメソッドでuse.idを保存している
    session[:user_id] = user.id
  end
  
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
  
  def user_info
    params.require(:session).permit(:email, :password)
  end
end
