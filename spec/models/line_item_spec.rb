require File.dirname(__FILE__) + '/../spec_helper'

describe LineItem do
  before(:each) do
    @line_item = LineItem.new
  end

  it "should belong to invoice" do
    @line_item.should belong_to(:invoice)
  end

  it "should have a rate" do
    @line_item.should validate_presence_of(:rate)
  end

  it "should have a quantity" do
    @line_item.should validate_presence_of(:quantity)
  end

end

describe LineItem, "'s magic functions vat and total" do

  describe "for an empty line item" do
    before(:each) do
      @line_item = LineItem.new
    end

    it "should return nil when calculating the vat" do
      @line_item.vat.should be_nil
    end

    it "should return nil when calculating the total" do
      @line_item.total.should be_nil
    end

  end

  describe "for a valid line" do
    before(:each) do
      @line_item = LineItem.new(:rate => 0.47, :quantity => 1256, :description => "Test", :vat_rate => 0.175)
    end
    
    it "should return the correct value when calculating vat" do
      @line_item.vat.should == BigDecimal.new("103.306")
    end

    it "should return the correct value for total" do
      @line_item.total.should == BigDecimal.new("693.626")
    end

  end
end
