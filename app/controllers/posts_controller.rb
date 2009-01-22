class PostsController < ApplicationController
  def show
    return @post = Post.most_recent_from_next_feed(params[:id]) if params[:next]
    @post = Post.find_by_url(params[:id])
  end

  def index
    @post = Post.most_recent_post(Post.first_feed)
  end
end
