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

describe "A Ledger" do

  before(:each) do
    @ledger = Ledger.new
  end

  it "should validate presence of loaded_from" do
    @ledger.should validate_presence_of(:loaded_from)
  end

end

describe "Loading a Ledger" do
  before(:each) do
    @journal_file = [{
      :org_type => "Invoice",
      :org_id => 3124,
      :posted_at => "2008-02-29",
      :new_transactions => [{
        :account => "Receivable",
        :amount => 130},
        { :account => "Sales", :amount => -130 }]
    }]
    def @journal_file.name
      "fred"
    end
  end

  def load_journal_file
    Ledger.load_journals(@journal_file)
  end

  it "should create a record with correct settings" do
    lambda {
      load_journal_file
    }.should change(Ledger, :count).by(1)
  end

  it "should not create anything with incorrect settings" do
    lambda {
      @journal_file[0].delete(:org_type)
      load_journal_file
    }.should_not change(Journal, :count)
  end

  it "should return the number of journals created" do
    amount = load_journal_file
    amount.should == 1
  end

  describe "when presented with rubbish" do
    before(:each) do
      @journal_file.delete_at 0
    end

    it "should not create a ledger" do
      lambda {
        load_journal_file
      }.should_not change(Ledger, :count)
    end
  end

end
