class PostCommentsController < ApplicationController

  def create
    tweet = Tweet.find(params[:tweet_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.tweet_id = tweet.id
    comment.save
    redirect_back fallback_location: root_path
  end

  def destroy
    PostComment.find(params[:id]).destroy
    redirect_back fallback_location: root_path
  end



private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end


end
