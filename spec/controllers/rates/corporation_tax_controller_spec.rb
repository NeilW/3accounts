require File.dirname(__FILE__) + '/../../spec_helper'

describe Rates::CorporationTaxController, "when requesting rates/corporation_tax" do

  before(:each) do
    @mock_ct_rate = mock_model(Rates::CorporationTax)
    @rates = [@mock_ct_rate]
    Rates::CorporationTax.stub!(:find).and_return(@rates)
  end

  describe "on an HTML GET to index" do
    before(:each) do
      get :index
    end

    it "should find all the rates" do
      assigns[:ct_rates].should equal(@rates)
    end

    it "should render the index template" do
      response.should render_template("index")
    end
    
  end

  describe "on an XML GET to index" do
    before(:each) do
      @mock_ct_rate.should_receive(:to_xml).once
      get :index, :format => 'xml'
    end

    it "should return a success" do
      response.should be_success
    end
  end
end

describe Rates::CorporationTaxController, "when requesting rates/corporation_tax with an id" do

  before(:each) do
    @rates = mock_model(Rates::CorporationTax)
  end

  describe "on an HTML GET when the id exists" do
    before(:each) do
      Rates::CorporationTax.should_receive(:find_by_fiscal_year_starting).with("2006").and_return @rates
      get :show, :id => 2006
    end

    it "should find the rate" do
      assigns[:ct_rates].should equal(@rates)
    end

    it "should render the show template" do
      response.should render_template("show")
    end
    
  end

  describe "on an HTML GET when the id doesn't exist" do
    before(:each) do
      get :show, :id => 2004
    end

    it "should not find anything" do
      assigns[:ct_rates].should be_nil
    end

    it "should return a not found error" do
      response.response_code.should == status_code(:not_found)
    end
  end

  describe "on an XML GET when the id exists" do
    before(:each) do
      Rates::CorporationTax.should_receive(:find_by_fiscal_year_starting).with("2006").and_return @rates
      @rates.should_receive(:to_xml).once
      get :show, :id => 2006, :format => 'xml'
    end

    it "should find the rate" do
      assigns[:ct_rates].should equal(@rates)
    end

    it "should return a success" do
      response.should be_a_success
    end
  end

  describe "on an XML GET when the id doesn't exist" do
    before(:each) do
      get :show, :id => 2004, :format => 'XML'
      @rates.should_not_receive(:to_xml)
    end

    it "should not find anything" do
      assigns[:ct_rates].should be_nil
    end

    it "should return a not found error" do
      response.response_code.should == status_code(:not_found)
    end
  end

end
