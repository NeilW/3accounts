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

describe CustomersController do
  describe "route generation" do

    it "should map { :controller => 'customers', :action => 'index' } to /customers" do
      route_for(:controller => "customers", :action => "index").should == "/customers"
    end
  
    it "should map { :controller => 'customers', :action => 'new' } to /customers/new" do
      route_for(:controller => "customers", :action => "new").should == "/customers/new"
    end
  
    it "should map { :controller => 'customers', :action => 'show', :id => 1 } to /customers/1" do
      route_for(:controller => "customers", :action => "show", :id => 1).should == "/customers/1"
    end
  
    it "should map { :controller => 'customers', :action => 'edit', :id => 1 } to /customers/1/edit" do
      route_for(:controller => "customers", :action => "edit", :id => 1).should == "/customers/1/edit"
    end
  
    it "should map { :controller => 'customers', :action => 'update', :id => 1} to /customers/1" do
      route_for(:controller => "customers", :action => "update", :id => 1).should == "/customers/1"
    end
  
    it "should map { :controller => 'customers', :action => 'destroy', :id => 1} to /customers/1" do
      route_for(:controller => "customers", :action => "destroy", :id => 1).should == "/customers/1"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'customers', action => 'index' } from GET /customers" do
      params_from(:get, "/customers").should == {:controller => "customers", :action => "index"}
    end
  
    it "should generate params { :controller => 'customers', action => 'new' } from GET /customers/new" do
      params_from(:get, "/customers/new").should == {:controller => "customers", :action => "new"}
    end
  
    it "should generate params { :controller => 'customers', action => 'create' } from POST /customers" do
      params_from(:post, "/customers").should == {:controller => "customers", :action => "create"}
    end
  
    it "should generate params { :controller => 'customers', action => 'show', id => '1' } from GET /customers/1" do
      params_from(:get, "/customers/1").should == {:controller => "customers", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'customers', action => 'edit', id => '1' } from GET /customers/1;edit" do
      params_from(:get, "/customers/1/edit").should == {:controller => "customers", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'customers', action => 'update', id => '1' } from PUT /customers/1" do
      params_from(:put, "/customers/1").should == {:controller => "customers", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'customers', action => 'destroy', id => '1' } from DELETE /customers/1" do
      params_from(:delete, "/customers/1").should == {:controller => "customers", :action => "destroy", :id => "1"}
    end
  end
end
