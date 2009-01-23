class Post < ActiveRecord::Base
  def self.most_recent_post(feedUrl)
    Post.find :first, :conditions => ["feedurl = ? and doneReading = 'f'", feedUrl], :order => "id desc"
  end

  def self.feed_for_post(url)
    Post.find_by_url(url).feedurl rescue nil
  end

  def self.next_feed(feedUrl)
    $FEEDS[$FEEDS.index(feedUrl)+1]
  end

  def self.most_recent_from_next_feed(url=nil)
    ans = nil
    nextFeedIndex = $FEEDS.index(feed_for_post(url))
    origFeedIndex = nextFeedIndex.nil? ? $FEEDS.length-1 : nextFeedIndex
    begin
      nextFeedIndex = next_feed_index(nextFeedIndex)
      ans = most_recent_post($FEEDS[nextFeedIndex])
    end until ans || nextFeedIndex == origFeedIndex
    ans
  end

  private

  def self.next_feed_index(idx)
    idx.nil? ? 0 : ((idx+1) % $FEEDS.length)
  end
end
