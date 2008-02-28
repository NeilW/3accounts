require File.dirname(__FILE__) + '/../spec_helper'

describe LineItem do
  before(:each) do
    @line_item = LineItem.new
  end

  it "should belong to invoice" do
    @line_item.should belong_to(:invoice)
  end

  it "should belong to vat_type" do
    @line_item.should belong_to(:vat_type)
  end

  it "should have a rate" do
    @line_item.should validate_presence_of(:rate)
  end

  it "should have a quantity" do
    @line_item.should validate_presence_of(:quantity)
  end

end

describe LineItem, "'s magic functions" do

  describe "for an empty line item" do
    before(:each) do
      @line_item = LineItem.new
    end

    it "should return nil when asked for the sub_total" do
      @line_item.sub_total.should be_nil
    end

    it "should return nil when asked for the total amount" do
      @line_item.total.should be_nil
    end

    it "should return nil when asked for the vat amount" do
      @line_item.vat.should be_nil
    end

    it "should return nil when asked for the vat rate" do
      @line_item.vat_rate.should be_nil
    end

  end

  describe "for a valid line calculating fractional VAT" do
    before(:each) do
      @line_item = LineItem.new(:rate => 16.97, :quantity => 1, :description => "Test")
      @line_item.vat_type = VatType.new(:rate => 0.175, :name => "Standard")
    end
    
    it "should return the correct value for vat (round down to 0.1p)" do
      @line_item.vat.should == BigDecimal.new("2.969")
    end

    it "should return the correct value for total" do
      @line_item.total.should == BigDecimal.new("19.939")
    end

    it "should return the correct value for sub_total" do
      @line_item.sub_total.should == BigDecimal.new("16.97")
    end

    it "should return the correct value for the vat rate" do
      @line_item.vat_rate.should == BigDecimal.new("0.175")
    end

  end
end
