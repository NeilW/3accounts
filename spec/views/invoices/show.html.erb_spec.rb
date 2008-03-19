require File.dirname(__FILE__) + '/../../spec_helper'

describe "/invoices/show.html.erb" do
  include InvoicesHelper
  
  before(:each) do
    @invoice = mock_model(Invoice)
    @invoice.stub!(:number).and_return("MyString")
    @invoice.stub!(:issued_at).and_return(Date.today)
    @invoice.stub!(:customer).and_return(Customer.new)
    @invoice.stub!(:total).and_return(100)
    @invoice.stub!(:line_items).and_return([])
    @current_business = mock_model(Business)
    @current_business.stub!(:name).and_return("BusinessName")

    assigns[:invoice] = @invoice
    assigns[:current_business] = @current_business
  end

  it "should render attributes in <p>" do
    render "/invoices/show.html.erb"
    response.should have_text(/MyString/)
  end
end

