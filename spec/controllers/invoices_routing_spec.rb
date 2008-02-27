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