require File.dirname(__FILE__) + '/../../spec_helper'

describe "/invoices/index.html.erb" do
  include InvoicesHelper
  
  before(:each) do
    invoice_98 = mock_model(Invoice)
    invoice_98.should_receive(:number).and_return("MyString")
    invoice_98.should_receive(:issued_at).and_return(Date.today)
    invoice_98.should_receive(:customer).and_return(mock_model(Customer, :name => 'Fred'))
    invoice_98.should_receive(:total).and_return(100)
    invoice_99 = mock_model(Invoice)
    invoice_99.should_receive(:number).and_return("MyString")
    invoice_99.should_receive(:issued_at).and_return(Date.today)
    invoice_99.should_receive(:customer).and_return(mock_model(Customer, :name => 'Fred'))
    invoice_99.should_receive(:total).and_return(100)

    assigns[:invoices] = [invoice_98, invoice_99]
  end

  it "should render list of invoices" do
    render "/invoices/index.html.erb"
    response.should have_tag("tr>td", "MyString", 2)
  end
end

