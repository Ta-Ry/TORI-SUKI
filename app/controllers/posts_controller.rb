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

    project_id = ENV["CLOUD_PROJECT_ID"]
      # Instantiates a client
      translate   = Google::Cloud::Translate.new version: :v2, project_id: project_id
      # The target language
      target = "ja"

  	if @post.save
      tags = Vision.get_image_data(@post.post_image)
      tags.each do |tag|
        # Translates some text into Japanese
      translated_tag = translate.translate tag, to: target

        #targetTag = Tag.find_by(name: tag)
        #@post.taggings.create()
        #若干力技で下の方法でない場合は上記２行を使用

        if Post.tagged_with(translated_tag).exists?
          @post.tag_list.add(translated_tag)
          @post.save
          #一度追加し保存は効率は悪いよ
        else
          @post.tags.create(name: translated_tag)
        end
      end
  		flash[:notice] = "無事投稿できました！"
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
  def all_tag
    @tags = Post.all_tags
    if params[:tag_name]
      @posts = Post.tagged_with("#{params[:tag_name]}")
    end
  end

  private

  def post_params
  	params.require(:post).permit(:main_comment, :post_image, :tag_list)
  end
end
