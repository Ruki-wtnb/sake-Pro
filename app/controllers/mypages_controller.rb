class MypagesController < ApplicationController
  
  def index
    @my_sake = Jsake.where(user_id: current_user.id)
  end
  
end