require File.dirname(__FILE__) + '/../spec_helper'

describe "VAT Type when blank" do
  before(:each) do
    @vat_type = VatType.new
  end

  it "should check for a unique name" do
    @vat_type.should validate_uniqueness_of(:name)
  end

  it "should check for that rate exists" do
    @vat_type.should validate_presence_of(:rate)
  end

  it "should not be valid" do
    @vat_type.should_not be_valid
  end

end

describe "A Vat Type when given a rate and unique name" do

  before(:each) do
    @vat_type = VatType.new(:name => "Standard", :rate => 0.175)
  end

  it "should be valid if rate is 0" do
    @vat_type.rate = 0
    @vat_type.should be_valid
  end

  it "should be valid if rate is 1" do
    @vat_type.rate = 0
    @vat_type.should be_valid
  end

  it "should not be valid if the rate is less than 0" do
    @vat_type.rate = -0.01
    @vat_type.should_not be_valid
  end
  
  it "should not be valid if the rate is greater than 1" do
    @vat_type.rate = 1.01
    @vat_type.should_not be_valid
  end
end

