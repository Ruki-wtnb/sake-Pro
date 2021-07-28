class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated?
      user.update_attribute(:activated, true)
      user.update_attribute(:activated_at, Time.zone.now)
      log_in user
      flash[:success] = "アカウントが有効化されました"
      redirect_to mypage_path
    else
      flash[:danger] = "無効な有効化リンクです"
      redirect_to root_path
    end
  end
end 
