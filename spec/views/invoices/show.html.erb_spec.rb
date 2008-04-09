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

