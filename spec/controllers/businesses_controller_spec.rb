require File.dirname(__FILE__) + '/../spec_helper'

describe BusinessesController do
  describe "handling GET /businesses" do

    before(:each) do
      @business = mock_model(Business)
      Business.stub!(:find).and_return([@business])
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
  
    it "should find all businesses" do
      Business.should_receive(:find).with(:all).and_return([@business])
      do_get
    end
  
    it "should assign the found businesses for the view" do
      do_get
      assigns[:businesses].should == [@business]
    end
  end

  describe "handling GET /businesses.xml" do

    before(:each) do
      @business = mock_model(Business, :to_xml => "XML")
      Business.stub!(:find).and_return(@business)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should find all businesses" do
      Business.should_receive(:find).with(:all).and_return([@business])
      do_get
    end
  
    it "should render the found businesses as xml" do
      @business.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /businesses/1" do

    before(:each) do
      @business = mock_model(Business)
      Business.stub!(:find).and_return(@business)
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
  
    it "should find the business requested" do
      Business.should_receive(:find).with("1").and_return(@business)
      do_get
    end
  
    it "should assign the found business for the view" do
      do_get
      assigns[:business].should equal(@business)
    end
  end

  describe "handling GET /businesses/1.xml" do

    before(:each) do
      @business = mock_model(Business, :to_xml => "XML")
      Business.stub!(:find).and_return(@business)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should find the business requested" do
      Business.should_receive(:find).with("1").and_return(@business)
      do_get
    end
  
    it "should render the found business as xml" do
      @business.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /businesses/new" do

    before(:each) do
      @business = mock_model(Business)
      Business.stub!(:new).and_return(@business)
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
  
    it "should create an new business" do
      Business.should_receive(:new).and_return(@business)
      do_get
    end
  
    it "should not save the new business" do
      @business.should_not_receive(:save)
      do_get
    end
  
    it "should assign the new business for the view" do
      do_get
      assigns[:business].should equal(@business)
    end
  end

  describe "handling GET /businesses/1/edit" do

    before(:each) do
      @business = mock_model(Business)
      Business.stub!(:find).and_return(@business)
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
  
    it "should find the business requested" do
      Business.should_receive(:find).at_least(:once).and_return(@business)
      do_get
    end
  
    it "should assign the found Business for the view" do
      do_get
      assigns[:business].should equal(@business)
    end
  end

  describe "handling POST /businesses" do

    before(:each) do
      @business = mock_model(Business, :to_param => "1")
      Business.stub!(:new).and_return(@business)
    end
    
    describe "with successful save" do
  
      def do_post
        @business.should_receive(:save).and_return(true)
        post :create, :business => {}
      end
  
      it "should create a new business" do
        Business.should_receive(:new).with({}).and_return(@business)
        do_post
      end

      it "should redirect to the new business" do
        do_post
        response.should redirect_to(business_url("1"))
      end
      
    end
    
    describe "with failed save" do

      def do_post
        @business.should_receive(:save).and_return(false)
        post :create, :business => {}
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template('new')
      end
      
    end
  end

  describe "handling PUT /businesses/1" do

    before(:each) do
      @business = mock_model(Business, :to_param => "1")
      Business.stub!(:find).and_return(@business)
    end
    
    describe "with successful update" do

      def do_put
        @business.should_receive(:update_attributes).and_return(true)
        put :update, :id => "1"
      end

      it "should find the business requested" do
        Business.should_receive(:find).with("1").and_return(@business)
        do_put
      end

      it "should update the found business" do
        do_put
        assigns(:business).should equal(@business)
      end

      it "should assign the found business for the view" do
        do_put
        assigns(:business).should equal(@business)
      end

      it "should redirect to the business" do
        do_put
        response.should redirect_to(business_url("1"))
      end

    end
    
    describe "with failed update" do

      def do_put
        @business.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end

    end
  end

  describe "handling DELETE /businesses/1" do

    before(:each) do
      @business = mock_model(Business, :destroy => true)
      Business.stub!(:find).and_return(@business)
    end
  
    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the business requested" do
      Business.should_receive(:find).with("1").and_return(@business)
      do_delete
    end
  
    it "should call destroy on the found business" do
      @business.should_receive(:destroy)
      do_delete
    end
  
    it "should redirect to the businesses list" do
      do_delete
      response.should redirect_to(businesses_url)
    end
  end
end
