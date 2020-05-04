class RelationshipsController < ApplicationController
	  def create
      @user = User.find(params[:follow_id])
    	following = current_user.follow(@user)
    	following.save

      respond_to do |format|
        format.html { redirect_to request.referrer || root_path }
        format.js
      end
  	end

  	def destroy
      @user = User.find(params[:follow_id])
    	following = current_user.unfollow(@user)
    	following.destroy

      respond_to do |format|
        format.html { redirect_to request.referrer || root_path }
        format.js
      end
  	end


end
