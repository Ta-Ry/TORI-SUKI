class HomeController < ApplicationController
  def top
  end

  def about
  end

  def bird_hospital
  end

  def lost_bird
	@posts = Post.all
    @tag = Tag.where(tag_name = "迷い鳥情報")
    if params[:tag_name]
    	@posts = Post.tagged_with("#{params[:tag_name]}")
    end
  end

  def contact
  end
end
