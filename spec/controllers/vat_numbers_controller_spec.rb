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

require File.dirname(__FILE__) + '/../spec_helper'

describe VatNumbersController do


  before(:each) do
    @vat_number = mock_model(VatNumber)
    @vat_number.stub!(:valid?).and_return(true)
    @vat_number.stub!(:active?).and_return(true)
    @vat_number.stub!(:to_xml)
    VatNumber.stub!(:new).and_return @vat_number
  end

  def do_get(parameters)
    get :show, {:country_code => 'gb', :identifier => 123456789, :format => 'html'}.merge(parameters)
  end

  %w(html xml).each do |format|

    describe "requests in #{format} format" do

      it "should be successful with correct VAT number" do
        do_get :format => format
        response.should be_success
      end

      it "should return Unprocessable Entity with bad VAT number" do
        @vat_number.should_receive(:valid?).and_return false
        do_get :identifier => 123, :format => format
        response.response_code.should == status_code(:unprocessable_entity)
      end

      it "should return Not Found if not active" do
        @vat_number.should_receive(:active?).and_return false
        do_get :format => format
        response.response_code.should == status_code(:not_found)
      end
    end
  end

  it "should handle compound VAT numbers properly" do
    get :show, :identifier => 'gb123456789'
    controller.params[:country_code].should == "gb"
    controller.params[:identifier].should == "123456789"
  end

end
