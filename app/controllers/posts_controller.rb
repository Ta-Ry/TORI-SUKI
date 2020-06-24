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
  end

  def create
  	@post = Post.new(post_params)
  	@post.user_id = current_user.id

    project_id = ENV["CLOUD_PROJECT_ID"]
      #クライアント
      translate   = Google::Cloud::Translate.new version: :v2, project_id: project_id
      #変更するタグの言語
      target = "ja"

  	if @post.save
      tags = Vision.get_image_data(@post.post_image)
      tags.each do |tag|
        #下記トランスレイトタグに'tag'の翻訳を収納
      translated_tag = translate.translate tag, to: target
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

  end

  def all_tag
    @tags = Post.all_tags
    @tags = @tags.where('name LIKE ?', "%#{params[:search]}%") if params[:search].present?
  end

  private

  def post_params
  	params.require(:post).permit(:main_comment, :post_image, :tag_list)
  end
end
