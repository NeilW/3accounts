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

describe "VAT Type when blank" do
  before(:each) do
    @vat_type = VatType.new
  end

  it "should check for a unique name" do
    @vat_type.should validate_uniqueness_of(:name)
  end

  it "should check for that rate exists" do
    @vat_type.should validate_presence_of(:rate)
  end

  it "should not be valid" do
    @vat_type.should_not be_valid
  end

end

describe "A Vat Type when given a rate and unique name" do

  before(:each) do
    @vat_type = VatType.new(:name => "Standard", :rate => 0.175)
  end

  it "should be valid if rate is 0" do
    @vat_type.rate = 0
    @vat_type.should be_valid
  end

  it "should be valid if rate is 1" do
    @vat_type.rate = 0
    @vat_type.should be_valid
  end

  it "should not be valid if the rate is less than 0" do
    @vat_type.rate = -0.01
    @vat_type.should_not be_valid
  end
  
  it "should not be valid if the rate is greater than 1" do
    @vat_type.rate = 1.01
    @vat_type.should_not be_valid
  end
end

