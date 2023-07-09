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
  to  = Time.current.at_end_of_day
  from  = (to - 6.day).at_beginning_of_day
  @tweets = Tweet.includes(:favorites).sort_by {|x| x.favorites.where(created_at: from...to).size}.reverse

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
