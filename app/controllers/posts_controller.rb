class PostsController < ApplicationController
  def show
    @post = Post.find_by_url params[:id]
  end
end
