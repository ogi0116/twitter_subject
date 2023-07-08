class UsersController < ApplicationController


  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets
    @tweet = Tweet.new
  end

  def edit
    @user = User.find(params[:id])

    if @user == current_user
      render :edit
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    user = User.find(current_user.id)
    user.update(user_params)
    redirect_to user_path(user)
  end

  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id:@user.id).pluck(:tweet_id)
    @favorite_tweets =Tweet.find(favorites)
    @tweet = Tweet.new
  end

  def follows
    user = User.find(params[:id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers
  end

private

def user_params
  params.require(:user).permit(:name, :profile_image, :introduction, :address, :birthday)
end

end
