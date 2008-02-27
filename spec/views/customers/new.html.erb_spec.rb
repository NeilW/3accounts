require File.dirname(__FILE__) + '/../../spec_helper'

describe "/customers/new.html.erb" do
  include CustomersHelper
  
  before(:each) do
    @customer = mock_model(Customer)
    @customer.stub!(:new_record?).and_return(true)
    @customer.stub!(:customer_name).and_return("MyString")
    assigns[:customer] = @customer
  end

  it "should render new form" do
    render "/customers/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", customers_path) do
      with_tag("input#customer_customer_name[name=?]", "customer[customer_name]")
    end
  end
end


