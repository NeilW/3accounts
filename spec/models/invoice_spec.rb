require File.dirname(__FILE__) + '/../spec_helper'

describe "An invoice" do
  before(:each) do
    @invoice = Invoice.new
  end

  it "should not allow duplicate invoice numbers" do
    @invoice.should validate_uniqueness_of(:number)
  end

  it "should make sure tax point is a valid date" do
    @invoice.should validate_presence_of(:issued_at)
  end

  it "should make sure that the invoice number exists" do
    @invoice.should validate_presence_of(:number)
  end

  it "should have many line items" do
    @invoice.should have_many(:line_items)
  end

  it "should belong to a customer" do
    @invoice.should belong_to(:customer)
  end

  it "should not be valid when blank" do
    @invoice.should_not be_valid
  end

end

describe "A non-blank invoice" do
  before(:each) do
    @invoice = Invoice.new(:number => "OAP001", :issued_at => '29-Feb-08')
  end

  it "should error on a missing customer" do
    @invoice.save
    @invoice.errors.on(:customer).should == "does not exist"
  end

  it "should error when the customer isn't in the database" do
    @invoice.customer_id = 1234
    @invoice.save
    @invoice.errors.on(:customer).should == "does not exist"
  end

  it "should error on missing line_items" do
    @invoice.save
    @invoice.errors.on(:line_items).should == "does not exist"
  end

  it "should error if a line item is invalid" do
    @invoice.line_items << LineItem.new(:rate => 10)
    @invoice.save
    @invoice.errors.on(:line_items).should include("is invalid")
  end

  describe "with a valid customer" do
    before(:each) do
      @invoice.customer = Customer.create(:name => "Fred")
    end

    it "should have no errors on the customer attribute" do
      @invoice.save
      @invoice.errors.on(:customer).should be_nil
    end

    it "should become a valid invoice if a valid line_item exists" do
      @invoice.line_items << LineItem.new(:rate => 10, :quantity => 2)
      @invoice.should be_valid
    end
  end
end

describe "A valid invoice" do

  def generate_line_item(options = {})
    LineItem.new( {
      :rate => 16.97,
      :quantity => 1,
      :description => "Something"
    }.merge!(options))
  end

  before(:each) do
    @vat_type = VatType.create(:name => "Standard", :rate => 0.175)
    @line_items = [generate_line_item(:vat_type => @vat_type),
      generate_line_item(:vat_type => @vat_type, :description => "Something else")
    ]
    @invoice = Invoice.new(
      :customer => Customer.create(:name => "Fred"),
      :line_items => @line_items,
      :number => "OAP001",
      :issued_at => "29-Feb-08"
    )
  end

  it "should provide the correct value for sub_total" do
    @invoice.sub_total.should == BigDecimal.new("33.94")
  end

  it "should provide the correct value for vat" do
    @invoice.vat.should == BigDecimal.new("5.93")
  end

  it "should provide the correct value for total" do
    @invoice.total.should == BigDecimal.new("39.87")
  end

  it "should error if the vat types are inconsistent" do
    @invoice.line_items[1].vat_type = nil
    @invoice.should_not be_valid
  end

  describe "with missing vat types in the line items" do
    before(:each) do
      @invoice.line_items.each { |item| item.vat_type = nil }
    end

    it "should be valid" do
      @invoice.should be_valid
    end

    it "should provide the correct value for vat (0)" do
      @invoice.vat.should == BigDecimal.new("0")
    end

    it "should provide the correct value for total" do
      @invoice.total.should == BigDecimal.new("33.94")
    end
  end

  describe "with different vat types in the line items" do
    before(:each) do
      @invoice.line_items[1].vat_type = VatType.create(:name => "Lower", :rate => 0.05)
    end
    
    it "should be valid" do
      @invoice.should be_valid
    end

    it "should provide the correct value for vat (0)" do
      @invoice.vat.should == BigDecimal.new("3.81")
    end

    it "should provide the correct value for total" do
      @invoice.total.should == BigDecimal.new("37.75")
    end

  end
end

