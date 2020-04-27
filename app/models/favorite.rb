class Favorite < ApplicationRecord
	def create
        @post = Post.find(params[:post_id])
        favorite = current_user.favorites.new(post_id: params[:post_id])
        favorite.save
        redirect_to request.referrer || root_url
    end
    def destroy
        @post = Post.find(params[:post_id])
        favorite = current_user.favorites.find_by(post_id: @post.id)
        favorite.destroy
        redirect_to request.referrer || root_url
    end
end
