require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PostsController do
  before(:each) do resetFeeds; end

  describe 'show' do
    it 'should show given piece' do
      get :show, :id => posts(:one).url
      response.should render_template('posts/show')
      assigns(:post).url.should == posts(:one).url
    end

    it 'should show most recent piece from _next_ feed' do
      get :show, :id => posts(:one).url, :next => true
      response.should render_template('posts/show')
      assigns(:post).url.should == posts(:six).url
    end
  end

  it 'should handle index' do
    get :index
    response.should render_template('posts/index')
    assigns(:post).should_not be_nil
  end

end
