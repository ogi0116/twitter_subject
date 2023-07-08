class TweetsController < ApplicationController
 before_action :authenticate_user!


  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id
    if @tweet.save
     redirect_to tweets_path, notice: "You have created tweet successfully."
    else
     @tweets = Tweet.all
     @user = current_user
     render 'index'
    end
  end

  def show
    @tweet = Tweet.find(params[:id])
    @new_tweet = Tweet.new
    @user = @tweet.user
    @post_comment = PostComment.new
  end

  def index
    @tweets = Tweet.all
    @user = current_user
    @tweet = Tweet.new
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
    redirect_to tweets_path
  end

  private

  def tweet_params
    params.require(:tweet).permit(:caption, :image)
  end



end
