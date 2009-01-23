class PostsController < ApplicationController
  def show
    p "show"
    @post = Post.find_by_url(params[:url])
  end

  def index
    @post = Post.most_recent_post(Post.first_feed)
  end

  def update
    p "update"
    curr_post = Post.find_by_url(params[:url])
    curr_post.doneReading = true
    curr_post.save

    @post = Post.most_recent_from_next_feed(params[:url])
    p "@post is now #{@post.url}"
  end
end
