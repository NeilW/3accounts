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

describe Period do
  before(:each) do
    @period = Period.new
  end

  it "should belong to Journal" do
    @period.should belong_to(:journal)
  end

  it "should have only one period per journal" do
    @period.should validate_uniqueness_of(:journal_id)
  end

  it "should have a start date" do
    @period.should validate_presence_of(:start_at)
  end

  it "should have an end date" do
    @period.should validate_presence_of(:end_at)
  end

  describe "model without a journal" do
    before(:each) do
      @period = Period.new(:start_at => "28-Feb-08", :end_at => "01-Mar-08")
    end

    it "should fail to validate" do
      @period.should_not validate
    end

  end

  describe "model with a journal" do
    fixtures :journals

    before(:each) do
      @period = Period.new(:start_at => "28-Feb-08", :end_at => "01-Mar-08")
      @period.journal = journals(:unattached)
    end

    it "should be valid with correct dates" do
      @period.should validate
    end

    it "should fail if dates are equal" do
      @period.end_at = @period.start_at
      @period.should_not validate
    end

    it "should fail if dates are out of sequence" do
      @period.end_at = @period.start_at.yesterday
      @period.should_not validate
    end

    it "should fail if journal doesn't exist" do
      @period.journal_id = 123
      @period.should_not validate
    end

  end



end
