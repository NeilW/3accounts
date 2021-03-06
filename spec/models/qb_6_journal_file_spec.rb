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

describe Qb6JournalFile, "Quickbooks Journal Load" do

  def get_journals
    @test.collect {|journal| journal}
  end

  describe "with a valid file" do
    before(:each) do
      @qb_extract = StringIO.new <<-DOC
Trans no	Type	Date	Num	Name	Memo	Account	Debit	Credit
2555	Deposit	01/11/2006			Interest	Abbey National	0.50	
					Interest	Interest Income		0.50
							0.50	0.50
2556	Credit Card Charge	03/11/2006	387565015	Virgin Mobile		Directors Loan		1.56
				Virgin Mobile	Mobiles	Mobile	1.33	
				Virgin Mobile	Total VAT	VAT Control	0.23	
							1.56	1.56
2558	Bill	15/11/2006		Ebay International		Accounts Payable		4.48
				Ebay International	Ebay Charges	eBay Charges	4.48	
				Ebay International	Total VAT	VAT Control	0.00	
							4.48	4.48
DOC
      @test = Qb6JournalFile.new(@qb_extract)
    end
    
    it "should load an extract correctly" do
      get_journals.should have(3).items
    end

    it "should have a nil name" do
      @test.name.should be_nil
    end

  end

  describe "with faulty input" do

    it "should error with an empty string as input" do
      lambda {
        @test = Qb6JournalFile.new("")
      }.should raise_error(ArgumentError)
    end

    it "should error with nil as input" do
      lambda {
        @test = Qb6JournalFile.new(nil)
      }.should raise_error(ArgumentError)
    end

    it "should handle an empty file" do
      @test = Qb6JournalFile.new(StringIO.new(""))
      get_journals.should == []
    end

  end

end
