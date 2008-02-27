require File.dirname(__FILE__) + '/../spec_helper'

describe Invoice do
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

end
