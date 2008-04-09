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

describe "/customers/index.html.erb" do
  include CustomersHelper
  
  before(:each) do
    customer_98 = mock_model(Customer)
    customer_98.should_receive(:customer_name).and_return("MyString")
    customer_99 = mock_model(Customer)
    customer_99.should_receive(:customer_name).and_return("MyString")

    assigns[:customers] = [customer_98, customer_99]
  end

  it "should render list of customers" do
    render "/customers/index.html.erb"
    response.should have_tag("tr>td", "MyString", 2)
  end
end

