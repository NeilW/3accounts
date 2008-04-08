require File.dirname(__FILE__) + '/../spec_helper'

describe VatNumber do
  before(:each) do
    @vat_number = VatNumber.new
  end

  it "should not be valid" do
    @vat_number.should_not be_valid
  end

  it "should strip garbage from identifier" do
    @vat_number.identifier = "aB1*+$% \t"
    @vat_number.identifier.should == "AB1*+"
  end
  
  it "should uppercase identifier" do
    @vat_number.identifier = "ab123"
    @vat_number.identifier.should == "AB123"
  end

  it "should uppercase country code" do
    @vat_number.country_code = "gb"
    @vat_number.country_code.should == "GB"
  end

  describe "with a GB identifier" do

    before(:each) do
      @vat_number.identifier = "123 4023 42"
      @vat_number.country_code = "gb"
    end

    it "should be valid" do
      @vat_number.should be_valid
    end

    (EU::MEMBER_STATES_COUNTRY_CODES - %w(GB BG CZ DE DK EE EL ES EU FI HU LT LU MT PT RO SI)).each do |member_state|
      it "should not be valid for #{member_state}" do
        @vat_number.country_code = member_state
        @vat_number.country_code.should == member_state
        @vat_number.should_not be_valid
      end
    end

    it "should not be active" do
      @vat_number.should_not be_active
    end

    it "should be active with an operational VAT number" do
      @vat_number.identifier = "665 4023 42"
      @vat_number.should be_active
    end

  end

end
