require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PostsController do
  before(:each) do
    $FEEDS = ['http://abstractstuff.livejournal.com']
  end

  it 'should handle show' do
    get :show, :id => posts(:one).url
    response.should render_template('posts/show')
    assigns(:post).should_not be_nil
  end

  it 'should handle index' do
    get :index
    response.should render_template('posts/index')
    assigns(:post).should_not be_nil
  end

end
