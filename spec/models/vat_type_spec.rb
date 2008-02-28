require File.dirname(__FILE__) + '/../spec_helper'

describe VatType do
  before(:each) do
    @vat_type = VatType.new
  end

  it "should be valid" do
    @vat_type.should be_valid
  end

end
