require File.dirname(__FILE__) + '/../spec_helper'

describe "An invoice" do
  before(:each) do
    @invoice = Invoice.new
  end

  it "should not allow duplicate invoice numbers" do
    @invoice.should validate_uniqueness_of(:number)
  end

  it "should make sure tax point is a valid date" do
    @invoice.should validate_presence_of(:tax_point)
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
    @invoice = Invoice.new(:number => "OAP001", :tax_point => '29-Feb-08')
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
