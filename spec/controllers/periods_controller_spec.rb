require File.dirname(__FILE__) + '/../spec_helper'

describe PeriodsController do
  before(:each) do
    @journal = mock_model(Journal, :posted_at => "28-Feb-08")
    Journal.stub!(:find).and_return(@journal)
    @period = mock_model(Period)
    @journal.stub!(:period).and_return(@period)
  end

  describe "handling GET /journals/:id/period" do

    def do_get
      get :show, :periodic_id => @journal.id
    end

    it "should redirect to edit" do
      do_get
      response.should redirect_to(edit_periodic_period_path(@journal))
    end

  end

  describe "handling GET /periods/new" do

    before(:each) do
      @period = mock_model(Period)
      Period.stub!(:new).and_return(@period)
    end
  
    def do_get
      get :new, :periodic_id => @journal.id
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render new template" do
      do_get
      response.should render_template('new')
    end
  
    it "should create an new period" do
      Period.should_receive(:new).and_return(@period)
      do_get
    end
  
    it "should not save the new period" do
      @period.should_not_receive(:save)
      do_get
    end
  
    it "should assign the new period for the view" do
      do_get
      assigns[:period].should equal(@period)
    end
  end

  describe "handling GET journals/:id/period/edit" do

    def do_get
      get :edit, :periodic_id => @journal.id
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render edit template" do
      do_get
      response.should render_template('edit')
    end
  
    it "should find the period requested" do
      do_get
      assigns[:period].should == @period
    end
  
    it "should assign the found Period for the view" do
      do_get
      assigns[:period].should equal(@period)
    end
  end

  describe "handling POST /periods" do

    before(:each) do
      @period = Period.new
      @period.stub!(:to_param).and_return("1")
      Period.stub!(:new).and_return(@period)
      @journal.stub!("period=")
      @journal.should_receive(:period).and_return(@period)
    end
    
    describe "with successful save" do
  
      def do_post
        @period.should_receive(:save).and_return(true)
        post :create, :periodic_id => @journal.id, :period => {}
      end
  
      it "should create a new period" do
        Period.should_receive(:new).with({}).and_return(@period)
        do_post
      end

      it "should redirect to the periodics list" do
        do_post
        response.should redirect_to(periodics_path)
      end
      
    end
    
    describe "with failed save" do

      def do_post
        @period.should_receive(:save).and_return(false)
        post :create, :periodic_id => @journal.id, :period => {}
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template('new')
      end
      
    end
  end

  describe "handling PUT /periods/1" do

    before(:each) do
      @period = mock_model(Period, :to_param => "1")
      @journal.stub!(:period).and_return(@period)
    end
    
    describe "with successful update" do

      def do_put
        @period.should_receive(:update_attributes).and_return(true)
        put :update, :periodic_id => @journal.id, :id => "1"
      end

      it "should find the period requested" do
        do_put
        assigns(:period).should == @period
      end

      it "should update the found period" do
        do_put
        assigns(:period).should equal(@period)
      end

      it "should assign the found period for the view" do
        do_put
        assigns(:period).should equal(@period)
      end

      it "should redirect to the periodics list" do
        do_put
        response.should redirect_to(periodics_path)
      end

    end
    
    describe "with failed update" do

      def do_put
        @period.should_receive(:update_attributes).and_return(false)
        put :update, :periodic_id => @journal.id, :id => "1"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end

    end
  end

  describe "handling DELETE /periods/1" do

    before(:each) do
      @period = mock_model(Period, :destroy => true)
      @journal.stub!(:period).and_return(@period)
    end
  
    def do_delete
      delete :destroy, :periodic_id => @journal.id
    end

    it "should find the period requested" do
      @journal.should_receive(:period).and_return(@period)
      do_delete
    end
  
    it "should call destroy on the found period" do
      @period.should_receive(:destroy)
      do_delete
    end
  
    it "should redirect to the periodics list" do
      do_delete
      response.should redirect_to(periodics_path)
    end
  end
end
