class SearchController < ApplicationController
  def search
  	search = params[:search_search]
    @posts = Post.search(search)
  end
end
