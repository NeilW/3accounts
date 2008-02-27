require File.dirname(__FILE__) + '/../../spec_helper'

describe "/customers/edit.html.erb" do
  include CustomersHelper
  
  before do
    @customer = mock_model(Customer)
    @customer.stub!(:customer_name).and_return("MyString")
    assigns[:customer] = @customer
  end

  it "should render edit form" do
    render "/customers/edit.html.erb"
    
    response.should have_tag("form[action=#{customer_path(@customer)}][method=post]") do
      with_tag('input#customer_customer_name[name=?]', "customer[customer_name]")
    end
  end
end


