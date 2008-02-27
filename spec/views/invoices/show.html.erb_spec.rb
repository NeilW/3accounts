require File.dirname(__FILE__) + '/../../spec_helper'

describe "/invoices/show.html.erb" do
  include InvoicesHelper
  
  before(:each) do
    @invoice = mock_model(Invoice)
    @invoice.stub!(:invoice_number).and_return("MyString")
    @invoice.stub!(:tax_point).and_return(Date.today)
    @invoice.stub!(:customer_id).and_return("1")

    assigns[:invoice] = @invoice
  end

  it "should render attributes in <p>" do
    render "/invoices/show.html.erb"
    response.should have_text(/MyString/)
  end
end

