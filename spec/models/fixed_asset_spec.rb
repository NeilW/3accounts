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

describe FixedAsset do
  fixtures :journals

  before(:each) do
    @fixed_asset = FixedAsset.new(:bought_on => "29-Feb-08",
                                  :bought_for => 100)
    @fixed_asset.journal = journals(:unattached)
  end

  it "should be validate presence of bought_for" do
    @fixed_asset.should validate_presence_of(:bought_for)
  end

  it "should validate presence of bought_on" do
    @fixed_asset.should validate_presence_of(:bought_on)
  end

  it "should belong to journal" do
    @fixed_asset.should belong_to(:journal)
  end

  it "should not accept a negative bought_for" do
    @fixed_asset.bought_for = -0.01
    @fixed_asset.should_not validate
  end

  it "should accept a zero bought_for" do
    @fixed_asset.bought_for = 0
    @fixed_asset.should validate
  end

  it "should not let sold_on be less than bought_on" do
    @fixed_asset.sold_on = @fixed_asset.bought_on.yesterday
    @fixed_asset.sold_for = 0
    @fixed_asset.should_not validate
  end

  it "should not accept a negative sold_for" do
    @fixed_asset.sold_on = @fixed_asset.bought_on
    @fixed_asset.sold_for = -0.01
    @fixed_asset.should_not validate
  end

  it "should accept a zero sold_for" do
    @fixed_asset.sold_on = @fixed_asset.bought_on
    @fixed_asset.sold_for = 0
    @fixed_asset.should validate
  end

  it "should accept a positive sold_for" do
    @fixed_asset.sold_for = @fixed_asset.bought_for
    @fixed_asset.sold_on = @fixed_asset.bought_on
    @fixed_asset.should validate
  end

  it "should have a sold_on if sold_for is set" do
    @fixed_asset.sold_for = 0
    @fixed_asset.should_not validate
  end

  it "should have a sold_for if sold_on is set" do
    @fixed_asset.sold_on = @fixed_asset.bought_on
    @fixed_asset.should_not validate
  end

  it "should fail to validate with a blank record" do
    @fixed_asset = FixedAsset.new
    @fixed_asset.should_not validate
  end

  it "should have only one asset per journal" do
    @fixed_asset.should validate_uniqueness_of(:journal_id)
  end

  it "should check that the journal exists" do
    @fixed_asset.journal_id = 9999
    @fixed_asset.should_not validate
  end

end
