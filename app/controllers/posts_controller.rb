class PostsController < ApplicationController
  def show
    @post = Post.find_by_url(params[:url])
  end

  def index
    @post = Post.most_recent_from_next_feed
    temporary_backpatch
  end

  def update
    Post.find_by_url(params[:url]).set_done

    @post = Post.most_recent_from_next_feed(params[:url])
    temporary_backpatch
  end

  private
  def temporary_backpatch
    @title = @post.title.blank? ? "###" : @post.title
    @home = @post.home.blank? ? "#" : @post.home
  end
end
