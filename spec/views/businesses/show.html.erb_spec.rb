require File.dirname(__FILE__) + '/../../spec_helper'

describe "/businesses/show.html.erb" do
  include BusinessesHelper
  
  before(:each) do
    @business = mock_model(Business)
    @business.stub!(:business_name).and_return("MyString")

    assigns[:business] = @business
  end

  it "should render attributes in <p>" do
    render "/businesses/show.html.erb"
    response.should have_text(/MyString/)
  end
end

