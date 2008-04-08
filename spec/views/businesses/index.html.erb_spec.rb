require File.dirname(__FILE__) + '/../../spec_helper'

describe "/businesses/index.html.erb" do
  include BusinessesHelper
  
  before(:each) do
    business_98 = mock_model(Business)
    business_98.should_receive(:business_name).and_return("MyString")
    business_99 = mock_model(Business)
    business_99.should_receive(:business_name).and_return("MyString")

    assigns[:businesses] = [business_98, business_99]
  end

  it "should render list of businesses" do
    render "/businesses/index.html.erb"
    response.should have_tag("tr>td", "MyString", 2)
  end
end

