class PostsController < ApplicationController
	before_action :authenticate_user!
	def index
  	@posts = Post.all
  	@post = Post.new
    @user = current_user
    if params[:tag_name]
      @posts = Post.tagged_with("#{params[:tag_name]}")
    end
  end

  def show
  	@post = Post.find(params[:id])
    @user = @post.user
    @post_comment = PostComment.new
    if params[:tag_name]
      @posts = Post.tagged_with("#{params[:tag_name]}")
    end
  end

  def create
  	@post = Post.new(post_params)
  	@post.user_id = current_user.id
  	if @post.save
  		flash[:notice] = "You have created post successfully."
  	    redirect_to post_path(@post)
  	else
  		@posts = Post.all
      @user = current_user
  		render action: :index
  	end
  end

  def destroy
  	@post = Post.find(params[:id])
  	@post.destroy
  	redirect_to posts_path
  end

  def favorite_list
    @posts = Post.all
    @post = Post.new
    @user = current_user
    @favorite = Favorite.where(user_id: current_user)
    if params[:tag_name]
      @posts = Post.tagged_with("#{params[:tag_name]}")
    end
  end

  def search
    #Viewのformで取得したパラメータをモデルに渡す
    @posts = Post.search(params[:search])
  end

  private

  def post_params
  	params.require(:post).permit(:main_comment, :post_image, :tag_list)
  end
end
