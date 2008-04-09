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

