class SearchController < ApplicationController
  def search
  	search = params[:search_search]
    @posts = Post.search(search)
    if params[:tag_name]
      @posts = Post.tagged_with("#{params[:tag_name]}")
    end
  end
end
