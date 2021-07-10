class ApplicationController < ActionController::Base
#マスターユーザ...userid:master password:master1234
#heroku...メールアドレス, prg_Java_Ruby099

#DB接続　heroku login →　heroku pg:psql -a young-everglades-09991
#定義したメソッドをビューでも使えるようにする
 helper_method :current_user, :logged_in?, :current_user

 #CSFR対策
 protect_from_forgery width: :exception
 
 #フラッシュの種類の追加
 add_flash_types :success, :info, :warning, :danger
 
 def current_user
  if (user_id = session[:user_id])
   @current_user ||= User.find_by(id: user_id)
  elsif (user_id = cookies.signed[:user_id])
   user = User.joins(:gender).find_by(id: user_id)
   if user && user.authenticated?(cookies[:remember_token])
    log_in user
    @current_user = user
   end
  end
 end
 
 def log_in(user) #sessionメソッドでuse.idを保存している
  session[:user_id] = user.id
 end
 
 def logged_in?
  !current_user.nil? #current_userが空ではない？
 end
 
end
