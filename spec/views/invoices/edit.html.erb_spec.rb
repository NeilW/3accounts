require File.dirname(__FILE__) + '/../../spec_helper'

describe "/invoices/edit.html.erb" do
  include InvoicesHelper
  
  before do
    @invoice = mock_model(Invoice)
    @invoice.stub!(:invoice_number).and_return("MyString")
    @invoice.stub!(:tax_point).and_return(Date.today)
    @invoice.stub!(:customer_id).and_return("1")
    assigns[:invoice] = @invoice
  end

  it "should render edit form" do
    render "/invoices/edit.html.erb"
    
    response.should have_tag("form[action=#{invoice_path(@invoice)}][method=post]") do
      with_tag('input#invoice_invoice_number[name=?]', "invoice[invoice_number]")
    end
  end
end


