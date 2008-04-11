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

describe LedgersController do
  describe "handling GET /ledgers" do

    before(:each) do
    end
  
    def do_get
      get :show
    end
  
    it "should be successful" do
      pending
    end
  end

  describe "handling GET /ledgers/new" do

    def do_get
      get :new
    end

    it "should be successful" do
      pending
    end
  
  end

  describe "handling POST /ledgers" do

    before(:each) do
    end
    
    describe "with successful save" do

      def do_post(file = "")
        post :create, :ledger => {:upload_file => file }
      end
  
      it "should error if passed nil parameters" do
        post :create
        flash[:error].should_not be_nil
        response.should redirect_to(new_ledgers_url)
      end

      it "should error if passed a blank string" do
        do_post
        flash[:error].should_not be_nil
        response.should redirect_to(new_ledgers_url)
      end

      it "should try to load journals if passed IO" do
        Ledger.should_receive(:load_journals).and_return(3)
        do_post(StringIO.new(""))
        flash[:notice].should_not be_nil
        response.should redirect_to(ledgers_url)
      end

    end
  end
    
  describe "handling DELETE /ledgers" do

    before(:each) do
      @ledger = mock_model(Ledger, :destroy => true)
      Ledger.stub!(:find).and_return(@ledger)
    end
  
    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the ledger requested" do
      Ledger.should_receive(:find).with("1").and_return(@ledger)
      do_delete
    end
  
    it "should call destroy on the found ledger" do
      @ledger.should_receive(:destroy)
      do_delete
    end
  
    it "should redirect to the ledgers list" do
      do_delete
      response.should redirect_to(new_ledgers_url)
    end
  end
end
