require File.dirname(__FILE__) + '/../../spec_helper'

describe "/customers/index.html.erb" do
  include CustomersHelper
  
  before(:each) do
    customer_98 = mock_model(Customer)
    customer_98.should_receive(:customer_name).and_return("MyString")
    customer_99 = mock_model(Customer)
    customer_99.should_receive(:customer_name).and_return("MyString")

    assigns[:customers] = [customer_98, customer_99]
  end

  it "should render list of customers" do
    render "/customers/index.html.erb"
    response.should have_tag("tr>td", "MyString", 2)
  end
end

