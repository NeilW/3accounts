require File.dirname(__FILE__) + '/../../spec_helper'

describe "/invoices/edit.html.erb" do
  include InvoicesHelper
  
  before do
    @invoice = mock_model(Invoice)
    @invoice.stub!(:number).and_return("MyString")
    @invoice.stub!(:issued_at).and_return(Date.today)
    @invoice.stub!(:line_items).and_return([])
    @invoice.stub!(:customer_id).and_return(1)
    @invoice.stub!(:sensible_line_items_size?)
    assigns[:invoice] = @invoice
    @business = mock_model(Business, :customers => [])
    assigns[:current_business] = @business
  end

  it "should render edit form" do
    render "/invoices/edit.html.erb"
    
    response.should have_tag("form[action=#{invoice_path(@invoice)}][method=post]") do
      with_tag('input#invoice_number[name=?]', "invoice[number]")
    end
  end
end


