require File.dirname(__FILE__) + '/../../spec_helper'

describe Rates::CorporationTax, "when first created" do
  before(:each) do
    @corporation_tax = Rates::CorporationTax.new
  end

  it "should not be valid" do
    @corporation_tax.should_not be_valid
  end

end

describe Rates::CorporationTax, "validation routines" do
  before(:each) do
    @corporation_tax = Rates::CorporationTax.new(
      :main_rate => 28,
      :small_companies_rate => 21,
      :mscr_lower_limit => 300000,
      :mscr_upper_limit => 1500000,
      :fiscal_year_starting => 2008
    )
  end

  it "should accept a valid record" do
    @corporation_tax.should be_valid
  end

  it "should calculate the correct MSCR fraction for a valid record" do
    @corporation_tax.mscr_fraction.should eql(0.0175)
  end

  it "should not allow a small companies rate higher that the main rate" do
    @corporation_tax.main_rate = 20
    @corporation_tax.should_not be_valid
  end

  it "should not allow a MSCR lower limit greater than the upper limit" do
    @corporation_tax.mscr_upper_limit = 299999
    @corporation_tax.should_not be_valid
  end

  it "should not allow fiscal years before 2006" do
    @corporation_tax.fiscal_year_starting = 2005
    @corporation_tax.should_not be_valid
  end

  it "should not allow values over 100 for the main rate" do
    @corporation_tax.main_rate = 101
    @corporation_tax.should_not be_valid
  end

  it "should not allow values less than 0 for the main rate" do
    @corporation_tax.main_rate = -1
    @corporation_tax.should_not be_valid
  end

  it "should not allow values over 100 for the small companies rate" do
    @corporation_tax.small_companies_rate = 101
    @corporation_tax.should_not be_valid
  end

  it "should not allow values less than 0 for the small companies rate" do
    @corporation_tax.small_companies_rate = -1 
    @corporation_tax.should_not be_valid
  end

end


