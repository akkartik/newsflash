require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Post do
  before(:each) do resetFeeds; end

  describe 'first_feed' do
    it 'should return first feed from $FEEDS list' do
      Post.first_feed.should == $FEEDS[0]
    end
  end

  describe 'most_recent_post' do
    it 'should return most recent unread post for a feed' do
      Post.most_recent_post(Post.first_feed).url.should == posts(:three).url
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
  end
end
