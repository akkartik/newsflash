class Post < ActiveRecord::Base
  def self.first_feed
    $FEEDS[0]
  end

  def self.most_recent_post(feedUrl)
    Post.find :first, :conditions => ["feedurl = ? and doneReading = 'f'", feedUrl], :order => "id desc"
  end

  def self.feed_for_post(url)
    Post.find_by_url(url).feedurl
  end

  def self.next_feed(feedUrl)
    $FEEDS[$FEEDS.index(feedUrl)+1]
  end

  def self.most_recent_from_next_feed(url)
    ans = nil
    origFeedIndex = nextFeedIndex = $FEEDS.index(feed_for_post(url))
    begin
      nextFeedIndex = next_feed_index(nextFeedIndex)
      ans = most_recent_post($FEEDS[nextFeedIndex])
    end until ans || nextFeedIndex == origFeedIndex
    ans
  end

  private

  def self.next_feed_index(idx)
    (idx+1) % $FEEDS.length
  end
end
