class CommentsController < ApplicationController
  
  def new
    @comment = Comment.new(user_id: current_user.id, jsake_id: params[:jsake_id])
    #コメントアイコンからjsake_idを受け取る
  end
  
  def create #コメントの新規作成
    comment = Comment.new(user_id: current_user.id, jsake_id: comment_params[:jsake_id], body: comment_params[:body])
    
    if comment.save
      redirect_to comment_params[:back_url], success: "コメントを投稿しました"
    else
      flash.now[:danger] = "コメントを投稿できませんでした"
      new
      render :new
    end
  end
  
  def edit
    @comment = Comment.find(params[:id])
  end
  
  def show
    @jsake = Jsake.find(params[:id])
  end
  
  def update
    comment = Comment.find(params[:id])
    comment.update!(body: comment_params[:body])
    redirect_to comment_params[:back_url], success: "コメントを修正しました" 
  end
  
  private #入力フォームからの受取
  def comment_params
    params.require(:comment).permit(:jsake_id, :body, :back_url)
  end
  
end
