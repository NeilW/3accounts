require File.dirname(__FILE__) + '/../../spec_helper'

describe "/businesses/new.html.erb" do
  include BusinessesHelper
  
  before(:each) do
    @business = mock_model(Business)
    @business.stub!(:new_record?).and_return(true)
    @business.stub!(:business_name).and_return("MyString")
    assigns[:business] = @business
  end

  it "should render new form" do
    render "/businesses/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", businesses_path) do
      with_tag("input#business_business_name[name=?]", "business[business_name]")
    end
  end
end


