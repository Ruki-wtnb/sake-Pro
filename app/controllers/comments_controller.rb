class CommentsController < ApplicationController
  def new
    @comment = Comment.new(user_id: current_user.id, jsake_id: params[:jsake_id])
  end
end
