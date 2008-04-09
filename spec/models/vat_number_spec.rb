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

describe VatNumber do
  before(:each) do
    @vat_number = VatNumber.new
  end

  it "should not be valid" do
    @vat_number.should_not be_valid
  end

  it "should strip garbage from identifier" do
    @vat_number.identifier = "aB1*+$% \t"
    @vat_number.identifier.should == "AB1*+"
  end
  
  it "should uppercase identifier" do
    @vat_number.identifier = "ab123"
    @vat_number.identifier.should == "AB123"
  end

  it "should uppercase country code" do
    @vat_number.country_code = "gb"
    @vat_number.country_code.should == "GB"
  end

  describe "with a GB identifier" do

    before(:each) do
      @vat_number.identifier = "123 4023 42"
      @vat_number.country_code = "gb"
    end

    it "should be valid" do
      @vat_number.should be_valid
    end

    (EU::MEMBER_STATES_COUNTRY_CODES - %w(GB BG CZ DE DK EE EL ES EU FI HU LT LU MT PT RO SI)).each do |member_state|
      it "should not be valid for #{member_state}" do
        @vat_number.country_code = member_state
        @vat_number.country_code.should == member_state
        @vat_number.should_not be_valid
      end
    end

    it "should not be active" do
      @vat_number.should_not be_active
    end

    it "should be active with an operational VAT number" do
      @vat_number.identifier = "665 4023 42"
      @vat_number.should be_active
    end

  end

end
