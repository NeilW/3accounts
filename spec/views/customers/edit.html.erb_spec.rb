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

describe "/customers/edit.html.erb" do
  include CustomersHelper
  
  before do
    @customer = mock_model(Customer)
    @customer.stub!(:customer_name).and_return("MyString")
    assigns[:customer] = @customer
  end

  it "should render edit form" do
    render "/customers/edit.html.erb"
    
    response.should have_tag("form[action=#{customer_path(@customer)}][method=post]") do
      with_tag('input#customer_customer_name[name=?]', "customer[customer_name]")
    end
  end
end


