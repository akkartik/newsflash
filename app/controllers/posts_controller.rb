class PostsController < ApplicationController
  def show
    @post = Post.find_by_url params[:id]
  end

  def index
    @post = Post.most_recent_post(Post.first_feed)
  end
end
