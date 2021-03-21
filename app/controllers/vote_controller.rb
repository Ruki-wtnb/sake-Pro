class VoteController < ApplicationController
  def create
    already_vote = Vote.find_by(user_id: current_user.id, jsake_id: params[:jsake_id])
    if already_vote != nil
      already_vote.delete
    end
    one_vote = Vote.new(vote_params)
    one_vote[:user_id] = current_user.id

    one_vote.save
    redirect_to new_comment_path(jsake_id: params[:jsake_id])
    
  end

  def destroy
  end

  private
  def vote_params
    params.permit(:jsake_id, :taste_id)
  end
end
