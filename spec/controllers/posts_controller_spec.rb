require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PostsController do
  it 'should handle show' do
    get :show, :id => posts(:one).url
    response.should render_template('posts/show')
    assigns(:post).should_not be_nil
  end

end
