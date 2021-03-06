require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Post do
  before(:each) do resetFixtures; end

  describe 'new' do
    it 'should lookup columns from files' do
      Post.find_by_url(posts(:one).url).should be_skipped
    end
  end

  describe 'most_recent_post' do
    it 'should return most recent unread post for a feed' do
      Post.most_recent_post($FEEDS[0]).url.should == posts(:three).url
    end

    it 'should return nil when no posts remain unread' do
      Post.most_recent_post($FEEDS[2]).should be_nil
    end
  end

  describe 'next_feed' do
    it 'should return next feed after this one from $FEEDS list' do
      Post.next_feed($FEEDS[0]).should == $FEEDS[1]
    end
  end

  describe 'feed_for_post' do
    it 'should return feedurl for given url' do
      Post.feed_for_post(posts(:one).url).should == $FEEDS[0]
    end
  end

  describe 'most_recent_from_next_feed' do
    it 'should return most recent unread post from next feed' do
      Post.most_recent_from_next_feed(posts(:one).url).should == posts(:six)
    end

    it 'should skip feeds with no unread posts' do
      Post.most_recent_from_next_feed(posts(:two).url).should == posts(:three)
    end

    it 'should start from first feed for nil' do
      Post.most_recent_from_next_feed.should == posts(:three)
    end
  end

  describe 'set_done' do
    it 'should set done flag in column file' do
      p = Post.find_by_url posts(:one).url
      p.should_not be_done
      p.set_done
      # Don't need to save!
      p.should be_done
    end
  end
end
