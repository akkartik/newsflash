require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PostsController do
  before(:each) do resetFixtures; end

  describe 'show' do
    it 'should show given piece' do
      get :show, :url => posts(:one).url
      response.should render_template('posts/show')
      assigns(:post).url.should == posts(:one).url
    end
  end

  it 'should handle index' do
    get :index
    response.should render_template('posts/index')
    assigns(:post).should_not be_nil
  end

  describe 'update' do
    it 'should update done flag' do
      put :update, :id => '0', :url => posts(:one).url
      Post.find_by_url(posts(:one).url).should be_done
    end

    it 'should show most recent piece from _next_ feed' do
      put :update, :id => '0', :url => posts(:one).url
      response.should render_template('posts/update')
      assigns(:post).url.should == posts(:six).url
    end
  end

end
