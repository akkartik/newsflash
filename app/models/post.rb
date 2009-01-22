class Post < ActiveRecord::Base
  def self.first_feed
    $FEEDS[0]
  end

  def self.most_recent_post(feedUrl)
    Post.find :first, :conditions => ["feedurl = ?", feedUrl], :order => "id desc"
  end
end
