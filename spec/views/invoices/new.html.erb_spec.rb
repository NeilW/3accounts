require File.dirname(__FILE__) + '/../../spec_helper'

describe "/invoices/new.html.erb" do
  include InvoicesHelper
  
  before(:each) do
    @invoice = mock_model(Invoice)
    @invoice.stub!(:new_record?).and_return(true)
    @invoice.stub!(:number).and_return("ABC001")
    @invoice.stub!(:tax_point).and_return(Date.today)
    @invoice.stub!(:customer).and_return("ACustomer")
    assigns[:invoice] = @invoice
  end

  it "should render new form" do
    render "/invoices/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", invoices_path) do
      with_tag("input#invoice_number[name=?]", "invoice[number]")
    end
  end
end


