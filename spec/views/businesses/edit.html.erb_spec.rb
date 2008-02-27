require File.dirname(__FILE__) + '/../../spec_helper'

describe "/businesses/edit.html.erb" do
  include BusinessesHelper
  
  before do
    @business = mock_model(Business)
    @business.stub!(:business_name).and_return("MyString")
    assigns[:business] = @business
  end

  it "should render edit form" do
    render "/businesses/edit.html.erb"
    
    response.should have_tag("form[action=#{business_path(@business)}][method=post]") do
      with_tag('input#business_business_name[name=?]', "business[business_name]")
    end
  end
end


