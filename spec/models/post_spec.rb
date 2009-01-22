require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Post do
  before(:each) do
    @valid_attributes = {
    }
    $FEEDS = ['http://abstractstuff.livejournal.com']
  end

  it "should create a new instance given valid attributes" do
    Post.create!(@valid_attributes)
  end

  describe 'first_feed' do
    it 'should work' do
      Post.first_feed.should == $FEEDS[0]
    end
  end

  describe 'most_recent_post' do
    it 'should return most recent post for a feed' do
      Post.most_recent_post(Post.first_feed).should_not be_nil
      Post.most_recent_post(Post.first_feed).url.should == posts(:one).url
    end
  end
end
