class ApplicationController < ActionController::Base

 helper_method :current_user, :logged_in?, :current_user
 
 protect_from_forgery width: :exception
 
 add_flash_types :success, :info, :warning, :danger
 
 def current_user
  if (user_id = session[:user_id])
   @current_user ||= User.find_by(id: user_id)
  elsif (user_id = cookies.signed[:user_id])
   user = User.find_by(id: user_id)
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
