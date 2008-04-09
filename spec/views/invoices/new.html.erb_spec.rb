#    3accounts - Accounts software for real people 
#    Copyright (C) 2008, Neil Wilson, Aldur Systems
#
#    This file is part of 3accounts
#
#    3accounts is free software: you can redistribute it and/or modify it
#    under the terms of the GNU Affero General Public License as published
#    by the Free Software Foundation, either version 3 of the License,
#    or (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#    Affero General Public License for more details.
#
#    You should have received a copy of the GNU Affero General
#    Public License along with this program.  If not, see
#    <http://www.gnu.org/licenses/>.
#

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


