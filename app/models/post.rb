POST_COLUMNS = ['done', 'read', 'skipped', 'junk']
class Post < ActiveRecord::Base
  def read?
    column_set? 'read'
  end
  def done?
    column_set? 'done'
  end
  def skipped?
    column_set? 'skipped'
  end
  def junk?
    column_set? 'junk'
  end
  def set_done
    set_column 'done'
  end

  def self.most_recent_post(feedUrl)
    Post.find(:all, :conditions => ["feedurl = ?", feedUrl], :order => "id desc").
        collect{|post| return post if !post.done?}[0]
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
    return 0 if idx.nil?
    return rand($FEEDS.length) if idx >= $RANDOM
    return (idx+1) % $FEEDS.length
  end

  def column_set?(col)
    `grep -c \"#{url}\" #{$METRICS_DIR}/#{col}`.to_i > 0
  end

  def set_column(col)
    `echo \"#{url}\" >> #{$METRICS_DIR}/#{col}` unless column_set?(col)
  end
end
