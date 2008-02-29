require File.dirname(__FILE__) + '/../spec_helper'

describe "A Line Item" do
  before(:each) do
    @line_item = LineItem.new
  end

  it "should belong to an invoice" do
    @line_item.should belong_to(:invoice)
  end

  it "should belong to a vat_type" do
    @line_item.should belong_to(:vat_type)
  end

  it "should have a rate" do
    @line_item.should validate_presence_of(:rate)
  end

  it "should have a quantity" do
    @line_item.should validate_presence_of(:quantity)
  end

end

describe "A Line Item" do

  describe "when blank" do
    before(:each) do
      @line_item = LineItem.new
    end
  
    it "should not be valid" do
      @line_item.should_not be_valid
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

  describe "when given a rate and quantity" do
    before(:each) do
      @line_item = LineItem.new(:rate => 16.97, :quantity => 1, :description => "Test")
    end

    describe "and associated with a Vat Type" do
      before(:each) do
        @line_item.vat_type = VatType.new(:rate => 0.175, :name => "Standard")
      end

      it "should be valid" do
        @line_item.should be_valid
      end

      it "should be seen as handling vat" do
        @line_item.should be_handling_vat
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

      it "should cache the vat value if given one" do
        @line_item.vat = 2.97
        @line_item.vat.should == BigDecimal.new("2.97")
      end

      it "should clear the cache if the vat type is cleared" do
        @line_item.vat = 2.97
        @line_item.vat_type = nil
        @line_item.vat.should be_nil
      end

    end

    describe "but missing a VAT association" do

      it "should be valid" do
        @line_item.should be_valid
      end

      it "should not be handling vat" do
        @line_item.should_not be_handling_vat
      end

      it "should return nil for vat" do
        @line_item.vat.should be_nil
      end

      it "should not cache a vat value" do
        @line_item.vat = 2.97
        @line_item.vat.should be_nil
      end

      it "should return the correct value for sub_total" do
        @line_item.sub_total.should == BigDecimal.new("16.97")
      end

      it "should return the correct value for total" do
        @line_item.total.should == BigDecimal.new("16.97")
      end

    end

    it "should error if the quantity is zero" do
      @line_item.quantity = 0
      @line_item.save
      @line_item.errors.on(:quantity).should == "must be a positive amount."
    end

    it "should error if the quantity is negative" do
      @line_item.quantity = -1
      @line_item.save
      @line_item.errors.on(:quantity).should == "must be a positive amount."
    end

  end

end
