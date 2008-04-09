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

describe InvoicesController do
  describe "route generation" do

    it "should map { :controller => 'invoices', :action => 'index' } to /invoices" do
      route_for(:controller => "invoices", :action => "index").should == "/invoices"
    end
  
    it "should map { :controller => 'invoices', :action => 'new' } to /invoices/new" do
      route_for(:controller => "invoices", :action => "new").should == "/invoices/new"
    end
  
    it "should map { :controller => 'invoices', :action => 'show', :id => 1 } to /invoices/1" do
      route_for(:controller => "invoices", :action => "show", :id => 1).should == "/invoices/1"
    end
  
    it "should map { :controller => 'invoices', :action => 'edit', :id => 1 } to /invoices/1/edit" do
      route_for(:controller => "invoices", :action => "edit", :id => 1).should == "/invoices/1/edit"
    end
  
    it "should map { :controller => 'invoices', :action => 'update', :id => 1} to /invoices/1" do
      route_for(:controller => "invoices", :action => "update", :id => 1).should == "/invoices/1"
    end
  
    it "should map { :controller => 'invoices', :action => 'destroy', :id => 1} to /invoices/1" do
      route_for(:controller => "invoices", :action => "destroy", :id => 1).should == "/invoices/1"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'invoices', action => 'index' } from GET /invoices" do
      params_from(:get, "/invoices").should == {:controller => "invoices", :action => "index"}
    end
  
    it "should generate params { :controller => 'invoices', action => 'new' } from GET /invoices/new" do
      params_from(:get, "/invoices/new").should == {:controller => "invoices", :action => "new"}
    end
  
    it "should generate params { :controller => 'invoices', action => 'create' } from POST /invoices" do
      params_from(:post, "/invoices").should == {:controller => "invoices", :action => "create"}
    end
  
    it "should generate params { :controller => 'invoices', action => 'show', id => '1' } from GET /invoices/1" do
      params_from(:get, "/invoices/1").should == {:controller => "invoices", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'invoices', action => 'edit', id => '1' } from GET /invoices/1;edit" do
      params_from(:get, "/invoices/1/edit").should == {:controller => "invoices", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'invoices', action => 'update', id => '1' } from PUT /invoices/1" do
      params_from(:put, "/invoices/1").should == {:controller => "invoices", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'invoices', action => 'destroy', id => '1' } from DELETE /invoices/1" do
      params_from(:delete, "/invoices/1").should == {:controller => "invoices", :action => "destroy", :id => "1"}
    end
  end
end
