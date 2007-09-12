require File.dirname(__FILE__) + '/../spec_helper.rb'

# An example of how to dynamically add to setup methods by including a module.
module SetupApp
  def self.included(base)
    if base.class.name == 'Spec::DSL::EvalModule'
      base.before(:each) do 

        request.stub!(:ssl?).and_return(true)
        @user = mock_user
        controller.stub!(:set_timezone).and_return(true)
        
      end # setup
    end # if
  end # included
end

context "/session/new GET" do
  controller_name :session
  include SetupApp
  
  it "should render new" do
    get :new
    response.should render_template('new')
  end
  
  it "should redirect to ssl" do
    request.stub!(:ssl?).and_return(false)
    get :new
    response.should redirect_to("https://test.host/session/new")
  end

end

describe "/session POST without remember me" do
  controller_name :session
  include SetupApp

  before(:each) do
    User.stub!(:authenticate).and_return(@user)
    # controller.stub!(:logged_in?).and_return(true)
  end

  it 'should authenticate user' do
    User.should_receive(:authenticate).with('user', 'password').and_return(@user)
    post :create, :login => 'user', :password => 'password'
  end

  it 'should login user' do
    controller.should_receive(:logged_in?).and_return(false)
    post :create
  end

  it "should not remember me" do
    post :create
    response.cookies["auth_token"].should be_nil
  end

  it "should redirect to root" do
    User.should_receive(:authenticate).and_return(@user)
    controller.should_receive(:logged_in?).and_return(true)

    post :create # stubbed user auth
    response.should redirect_to('https://test.host:80/')
  end
end

describe "/session POST with remember me" do
  controller_name :session
  include SetupApp
  
  before(:each) do
    @ccookies = mock('cookies')
    User.stub!(:authenticate).and_return(@user)
    @user.stub!(:remember_me)

    controller.stub!(:cookies).and_return(@ccookies)
    controller.stub!(:logged_in?).and_return(true)

    @ccookies.stub!(:[]=)
    @ccookies.stub!(:[])
    @user.stub!(:remember_token).and_return('1111')
    @user.stub!(:remember_token_expires_at).and_return(Time.now)
  end

  it "should remember me" do
    @user.should_receive(:remember_me)
    post :create, :login => "derek", :password => "password", :remember_me => "1"
  end    

  it 'should create cookie' do
    @ccookies.should_receive(:[]=).with(:auth_token, { :value => '1111' , :expires => @user.remember_token_expires_at })
    post :create, :login => "derek", :password => "password", :remember_me => "1"
  end
end

describe "/session POST when invalid" do
  controller_name :session
  include SetupApp

  before(:each) do
    controller.stub!(:logged_in?).and_return(false, false)
    User.stub!(:authenticate).and_return(nil)
  end

  it 'should authenticate user' do
    User.should_receive(:authenticate).with('user', 'password').and_return(nil)
    post :create, :login => 'user', :password => 'password'
  end

  it 'should login user' do
    controller.should_receive(:logged_in?).and_return(false)
    post :create
  end

  it "should not remember me" do
    post :create
    response.cookies["auth_token"].should be_nil
  end

  it "should render new" do
    post :create
    response.should render_template('new')
  end
end

describe "/session DELETE" do
  controller_name :session
  include SetupApp

  before(:each) do
    @ccookies = mock('cookies')
    controller.stub!(:current_user).and_return(@user)
    controller.stub!(:logged_in?).and_return(true)
    @user.stub!(:forget_me)
    controller.stub!(:cookies).and_return(@ccookies)
    @ccookies.stub!(:delete)
    @ccookies.stub!(:[])
    response.cookies.stub!(:delete)
    controller.stub!(:reset_session)
    
  end

  it "should get current user" do
    controller.should_receive(:current_user).and_return(@user)
    delete :destroy
  end

  it 'should forget current user' do
    @user.should_receive(:forget_me)
    delete :destroy
  end

  it "should delete token on logout" do
    @ccookies.should_receive(:delete).with(:auth_token)
    delete :destroy
  end

  it 'should reset session' do 
    controller.should_receive(:reset_session)
    delete :destroy
  end

  it "should redirect to root" do
    delete :destroy
    response.should redirect_to('https://test.host:80/')
  end
end
