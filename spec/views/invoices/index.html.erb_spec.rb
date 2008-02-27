require File.dirname(__FILE__) + '/../../spec_helper'

describe "/invoices/index.html.erb" do
  include InvoicesHelper
  
  before(:each) do
    invoice_98 = mock_model(Invoice)
    invoice_98.should_receive(:invoice_number).and_return("MyString")
    invoice_98.should_receive(:tax_point).and_return(Date.today)
    invoice_98.should_receive(:customer_id).and_return("1")
    invoice_99 = mock_model(Invoice)
    invoice_99.should_receive(:invoice_number).and_return("MyString")
    invoice_99.should_receive(:tax_point).and_return(Date.today)
    invoice_99.should_receive(:customer_id).and_return("1")

    assigns[:invoices] = [invoice_98, invoice_99]
  end

  it "should render list of invoices" do
    render "/invoices/index.html.erb"
    response.should have_tag("tr>td", "MyString", 2)
  end
end

