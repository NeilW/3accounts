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