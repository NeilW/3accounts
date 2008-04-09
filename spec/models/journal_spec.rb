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

describe "A journal" do

  before(:each) do
    @journal = Journal.new
  end
  
  it "should validate presence of org_type" do
    @journal.should validate_presence_of(:org_type)
  end

  it "should validate presence of org_id" do
    @journal.should validate_presence_of(:org_id)
  end

  it "should validate uniqueness of org_id" do
    @journal.should validate_uniqueness_of(:org_id)
  end

  it "should validate presence of posted_at" do
    @journal.should validate_presence_of(:posted_at)
  end

  it "should validate existence of ledger" do
    @journal = Journal.new(:org_type => "Deposit",
                           :org_id => 2555,
                           :posted_at => "2008-02-29",
                           :ledger_id => 9999)
    @journal.should have(1).errors_on(:ledger)
  end

end

