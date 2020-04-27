class Post < ApplicationRecord
	before_action :authenticate_user!
	def index
  	@posts = Post.all
  	@post = Post.new
    @user = current_user
  end

  def show
  	@post = Post.find(params[:id])
    @user = @post.user
    @post_comment = PostComment.new
  end

  def edit
  	@post = Post.find(params[:id])
    @user = @post.user
    if current_user != @user
      redirect_to posts_path
    end
  end

  def create
  	@post = Post.new(post_params)
  	@post.user_id = current_user.id
  	if @post.save
  		flash[:notice] = "投稿しました！"
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

  private

  def post_params
  	params.require(:post).permit(:title, :body)
  end
end
