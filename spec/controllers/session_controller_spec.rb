require File.dirname(__FILE__) + '/../spec_helper'

describe SessionController, "with no live session" do
  it "should be a SessionController" do
    controller.should be_an_instance_of(SessionController)
  end

  it "should render new template when asked" do
    get :new
    response.should be_success
    response.should render_template("new")
  end

  it "should fail to create a session if no open id given" do
    post :create, {:openid_url => ""}
    flash[:notice].should_not be_empty
    response.should redirect_to(:action => 'new')
  end

  it "should create a session with a successful open_id" do
    controller.stub!(:authenticate_with_open_id).and_return([true, "www.fred.com", "mike@email.com"])
    post :create, {:openid_url => "www.fred.com"}
    controller.should be_logged_in
    flash[:notice].should_not be_empty
    response.should be_redirect
  end
end

describe SessionController, "with live session" do

  before(:each) do
    @user = mock_model(User)
    User.stub!(:find).and_return(@user)
    @user.stub!(:forget_me)
  end

  it "should remove all traces of session on destroy" do
    get :new
    store_login_in_session
    post :destroy
    controller.should_not be_logged_in
    response.session[:return_to].should be_nil
    response.session[:user].should be_nil
    response.cookies[:auth_token].should be_nil
    flash[:notice].should_not be_empty
    response.should be_redirect
  end

end

private

def store_login_in_session
  request.session[:user] = 1
end
