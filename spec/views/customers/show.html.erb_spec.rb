require File.dirname(__FILE__) + '/../../spec_helper'

describe "/customers/show.html.erb" do
  include CustomersHelper
  
  before(:each) do
    @customer = mock_model(Customer)
    @customer.stub!(:customer_name).and_return("MyString")

    assigns[:customer] = @customer
  end

  it "should render attributes in <p>" do
    render "/customers/show.html.erb"
    response.should have_text(/MyString/)
  end
end

