require File.dirname(__FILE__) + '/../spec_helper'

describe InvoicesController do
  describe "handling GET /invoices" do

    before(:each) do
      @invoice = mock_model(Invoice)
      Invoice.stub!(:find).and_return([@invoice])
    end
  
    def do_get
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should render index template" do
      do_get
      response.should render_template('index')
    end
  
    it "should find all invoices" do
      Invoice.should_receive(:find).with(:all).and_return([@invoice])
      do_get
    end
  
    it "should assign the found invoices for the view" do
      do_get
      assigns[:invoices].should == [@invoice]
    end
  end

  describe "handling GET /invoices.xml" do

    before(:each) do
      @invoice = mock_model(Invoice, :to_xml => "XML")
      Invoice.stub!(:find).and_return(@invoice)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should find all invoices" do
      Invoice.should_receive(:find).with(:all).and_return([@invoice])
      do_get
    end
  
    it "should render the found invoices as xml" do
      @invoice.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /invoices/1" do

    before(:each) do
      @invoice = mock_model(Invoice)
      Invoice.stub!(:find).and_return(@invoice)
    end
  
    def do_get
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render show template" do
      do_get
      response.should render_template('show')
    end
  
    it "should find the invoice requested" do
      Invoice.should_receive(:find).with("1").and_return(@invoice)
      do_get
    end
  
    it "should assign the found invoice for the view" do
      do_get
      assigns[:invoice].should equal(@invoice)
    end
  end

  describe "handling GET /invoices/1.xml" do

    before(:each) do
      @invoice = mock_model(Invoice, :to_xml => "XML")
      Invoice.stub!(:find).and_return(@invoice)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should find the invoice requested" do
      Invoice.should_receive(:find).with("1").and_return(@invoice)
      do_get
    end
  
    it "should render the found invoice as xml" do
      @invoice.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /invoices/new" do

    before(:each) do
      @invoice = mock_model(Invoice)
      Invoice.stub!(:new).and_return(@invoice)
    end
  
    def do_get
      get :new
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render new template" do
      do_get
      response.should render_template('new')
    end
  
    it "should create an new invoice" do
      Invoice.should_receive(:new).and_return(@invoice)
      do_get
    end
  
    it "should not save the new invoice" do
      @invoice.should_not_receive(:save)
      do_get
    end
  
    it "should assign the new invoice for the view" do
      do_get
      assigns[:invoice].should equal(@invoice)
    end
  end

  describe "handling GET /invoices/1/edit" do

    before(:each) do
      @invoice = mock_model(Invoice)
      Invoice.stub!(:find).and_return(@invoice)
    end
  
    def do_get
      get :edit, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render edit template" do
      do_get
      response.should render_template('edit')
    end
  
    it "should find the invoice requested" do
      Invoice.should_receive(:find).and_return(@invoice)
      do_get
    end
  
    it "should assign the found Invoice for the view" do
      do_get
      assigns[:invoice].should equal(@invoice)
    end
  end

  describe "handling POST /invoices" do

    before(:each) do
      @invoice = mock_model(Invoice, :to_param => "1")
      Invoice.stub!(:new).and_return(@invoice)
    end
    
    describe "with successful save" do
  
      def do_post
        @invoice.should_receive(:save).and_return(true)
        post :create, :invoice => {}
      end
  
      it "should create a new invoice" do
        Invoice.should_receive(:new).with({}).and_return(@invoice)
        do_post
      end

      it "should redirect to the new invoice" do
        do_post
        response.should redirect_to(invoice_url("1"))
      end
      
    end
    
    describe "with failed save" do

      def do_post
        @invoice.should_receive(:save).and_return(false)
        post :create, :invoice => {}
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template('new')
      end
      
    end
  end

  describe "handling PUT /invoices/1" do

    before(:each) do
      @invoice = mock_model(Invoice, :to_param => "1")
      Invoice.stub!(:find).and_return(@invoice)
    end
    
    describe "with successful update" do

      def do_put
        @invoice.should_receive(:update_attributes).and_return(true)
        put :update, :id => "1"
      end

      it "should find the invoice requested" do
        Invoice.should_receive(:find).with("1").and_return(@invoice)
        do_put
      end

      it "should update the found invoice" do
        do_put
        assigns(:invoice).should equal(@invoice)
      end

      it "should assign the found invoice for the view" do
        do_put
        assigns(:invoice).should equal(@invoice)
      end

      it "should redirect to the invoice" do
        do_put
        response.should redirect_to(invoice_url("1"))
      end

    end
    
    describe "with failed update" do

      def do_put
        @invoice.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end

    end
  end

  describe "handling DELETE /invoices/1" do

    before(:each) do
      @invoice = mock_model(Invoice, :destroy => true)
      Invoice.stub!(:find).and_return(@invoice)
    end
  
    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the invoice requested" do
      Invoice.should_receive(:find).with("1").and_return(@invoice)
      do_delete
    end
  
    it "should call destroy on the found invoice" do
      @invoice.should_receive(:destroy)
      do_delete
    end
  
    it "should redirect to the invoices list" do
      do_delete
      response.should redirect_to(invoices_url)
    end
  end
end