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

describe PeriodicsController do
  describe "handling GET /periodics" do

    before(:each) do
    end
  
    def do_get
      get :index
    end
  
    it "should render index template " do
      do_get
      flash[:error].should be_nil
      response.should render_template("periodics/index")
    end

    it "should paginate journals if ledger found" do
      @ledger = mock_model(Ledger)
      @journals = [Journal.new]
      @ledger.stub!(:periodic_journals).and_return(@journals)
      Journal.stub!(:paginate).and_return(@journals)
      Ledger.should_receive(:find).with(:first).and_return(@ledger)
      do_get
      assigns[:journals].should == @journals
    end

  end
end

