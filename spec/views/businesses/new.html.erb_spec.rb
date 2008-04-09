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

describe "/businesses/new.html.erb" do
  include BusinessesHelper
  
  before(:each) do
    @business = mock_model(Business)
    @business.stub!(:new_record?).and_return(true)
    @business.stub!(:business_name).and_return("MyString")
    assigns[:business] = @business
  end

  it "should render new form" do
    render "/businesses/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", businesses_path) do
      with_tag("input#business_business_name[name=?]", "business[business_name]")
    end
  end
end


