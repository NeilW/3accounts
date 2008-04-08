require File.dirname(__FILE__) + '/../../spec_helper'

describe "/invoices/new.html.erb" do
  include InvoicesHelper
  
  before(:each) do
    @invoice = mock_model(Invoice)
    @invoice.stub!(:new_record?).and_return(true)
    @invoice.stub!(:number).and_return("ABC001")
    @invoice.stub!(:issued_at).and_return(Date.today)
    @invoice.stub!(:line_items).and_return([])
    @invoice.stub!(:sensible_line_items_size?)
    @invoice.stub!(:customer_id)
    assigns[:invoice] = @invoice
    @business = mock_model(Business, :customers => [])
    assigns[:current_business] = @business
  end

  it "should render new form" do
    render "/invoices/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", invoices_path) do
      with_tag("input#invoice_number[name=?]", "invoice[number]")
    end
  end
end


