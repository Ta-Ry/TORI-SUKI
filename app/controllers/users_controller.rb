class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
  	@user = User.find(params[:id])
  	@post = Post.new
  	@posts = @user.posts
  end

  def edit
  	@user = User.find(params[:id])
    if current_user != @user
      redirect_to user_path(current_user)
    end
  end

  def update
  	@user = User.find(params[:id])
  	 if @user.update(user_params)
  	 	flash[:notice] = "会員情報更新しました！."
  	    redirect_to user_path(@user.id)
     else
      render action: :edit
     end
  end

  def withdrawal
  end

  def follow_list
    @user = User.find(params[:user_id])
  end

  def follower_list
    @user = User.find(params[:user_id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction, :email)
  end
end
