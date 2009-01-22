class Post < ActiveRecord::Base
  def self.first_feed
    $FEEDS[0]
  end

  def self.most_recent_post(feedUrl)
    Post.find :first, :conditions => ["feedurl = ?", feedUrl], :order => "id desc"
  end

  def self.feed_for_post(url)
    Post.find_by_url(url).feedurl
  end

  def self.next_feed(feedUrl)
    $FEEDS[$FEEDS.index(feedUrl)+1]
  end

  def self.most_recent_from_next_feed(url)
    nextFeedIndex = ($FEEDS.index(feed_for_post(url))+1) % $FEEDS.length
    most_recent_post($FEEDS[nextFeedIndex])
  end
end
