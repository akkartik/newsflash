class PostsController < ApplicationController
  after_filter :temporary_backpatch

  def show
    @post = Post.find_by_url(params[:url])
  end

  def index
    @post = Post.most_recent_from_next_feed
  end

  def update
    curr_post = Post.find_by_url(params[:url])
    curr_post.doneReading = true
    curr_post.save

    @post = Post.most_recent_from_next_feed(params[:url])
  end

  private

  def temporary_backpatch
    @title = "###" if @post.title.blank?
    @home = "#" if @post.home.blank?
  end
end
