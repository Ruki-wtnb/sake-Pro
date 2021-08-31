class CommentsController < ApplicationController
 
 def new
  @jsake = Jsake.find(params[:id])
  @comment = Comment.new(user_id: current_user.id, jsake_id: params[:jsake_id])
  @taste = Taste.all
 end
  
 def create
  comment = Comment.new(user_id: current_user.id, jsake_id: comment_params[:jsake_id], body: comment_params[:body])
  
  if comment.save
   redirect_to params[:comment][:back_url], success: "コメントを投稿しました"
  else
   flash.now[:danger] = "コメントを投稿できませんでした"
   new
   render :new
  end
 end

 def edit
  @jsake = Jsake.find(params[:id])
  @comment = Comment.find(params[:id])
 end

 def update
  comment = Comment.find(params[:id])
  comment.update!(body: comment_params[:body])
  redirect_to params[:comment][:back_url], success: "コメントを修正しました" 
 end

 def show
  binding.pry
  @jsake = Jsake.find(params[:id])
  @comment = Comment.find_by(params[:id])
  @body = Comment.where(jsake_id: params[:id])
  # search_sake = []
  # search_sake.push([@jsake.meigara, @jsake.sake_meter_value.to_f, @jsake.acidity.to_f])
  # @chart, @x, @y, @color = TopsController.get_data(search_sake)
 end

 def destroy
  comment = Comment.find(params[:comment_id])
  comment.destroy
  redirect_to action: :show
 end
  
 private
  def comment_params
   params.require(:comment).permit(:jsake_id, :body)
  end
  
end
