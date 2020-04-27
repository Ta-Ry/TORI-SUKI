class Relationship < ApplicationRecord
	before_action :set_user
	  def create
    	following = current_user.follow(@user)
    	following.save

      respond_to do |format|
        format.html { redirect_to request.referrer || root_path }
        format.js
      end
  	end

  	def destroy
    	following = current_user.unfollow(@user)
    	following.destroy

      respond_to do |format|
        format.html { redirect_to request.referrer || root_path }
        format.js
      end
  	end

 	private

    def set_user
    	@user = User.find(params[:follow_id])
    end
end
