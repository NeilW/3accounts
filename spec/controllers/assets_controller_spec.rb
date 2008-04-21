require File.dirname(__FILE__) + '/../spec_helper'

describe AssetsController do
  describe "while doing a POST /bills/:id/asset" do

    before(:each) do
      @journal = mock_model(Journal, :posted_at => "29-Feb-08",
                            :original_cost => 100,
                           :fixed_asset => nil)
      Journal.stub!(:find).and_return(@journal)
      @journal.stub!('fixed_asset=')
    end
    
    def do_post
      post :create, :bill_id => @journal.id, :asset => {}
    end

    it "should create a fixed asset record from the journal" do
      FixedAsset.should_receive(:new).with(
        :bought_for => @journal.original_cost,
        :bought_on => @journal.posted_at)
      @journal.should_receive(:save).and_return(true)
      do_post
      flash[:notice].should_not be_blank
      response.should redirect_to(bills_path)
    end

    it "should generate an error if the save fails" do
      @journal.should_receive(:save).and_return(false)
      do_post
      flash[:error].should_not be_blank
      response.should redirect_to(bills_path)
    end

    it "should generate error if fixed_asset already exists" do
      @journal.should_receive(:fixed_asset).and_return(FixedAsset.new)
      do_post
      flash[:error].should_not be_blank
      response.should redirect_to(bills_path)
    end
  end

  describe "while doing a DELETE /bills/:id/asset" do
     before(:each) do
       @journal = mock_model(Journal, :fixed_asset => nil)
       Journal.stub!(:find).and_return @journal
     end

     def do_delete
       delete :destroy, :bill_id => @journal.id
     end

     it "should error if there is no fixed asset" do
       do_delete
       flash[:error].should_not be_blank
       response.should redirect_to(bills_path)
     end

     it "should delete the record if it exists" do
       @journal.stub!(:fixed_asset).and_return(FixedAsset.new)
       do_delete
       flash[:notice].should_not be_blank
       response.should redirect_to(bills_path)
     end


  end


end
