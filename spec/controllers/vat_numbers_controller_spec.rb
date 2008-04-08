require File.dirname(__FILE__) + '/../spec_helper'

describe VatNumbersController do


  before(:each) do
    @vat_number = mock_model(VatNumber)
    @vat_number.stub!(:valid?).and_return(true)
    @vat_number.stub!(:active?).and_return(true)
    VatNumber.stub!(:new).and_return @vat_number
  end

  def do_get(parameters)
    get :show, {:country_code => 'gb', :identifier => 123456789, :format => 'html'}.merge(parameters)
  end

  %w(html xml).each do |format|

    describe "requests in #{format} format" do

      it "should be successful with correct VAT number" do
        do_get :format => format
        response.should be_success
      end

      it "should return Unprocessable Entity with bad VAT number" do
        @vat_number.should_receive(:valid?).and_return false
        do_get :identifier => 123, :format => format
        response.response_code.should == status_code(:unprocessable_entity)
      end

      it "should return Not Found if not active" do
        @vat_number.should_receive(:active?).and_return false
        do_get :format => format
        response.response_code.should == status_code(:not_found)
      end
    end
  end

  it "should handle compound VAT numbers properly" do
    get :show, :identifier => 'gb123456789'
    controller.params[:country_code].should == "gb"
    controller.params[:identifier].should == "123456789"
  end

end
