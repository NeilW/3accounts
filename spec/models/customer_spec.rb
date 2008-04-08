require File.dirname(__FILE__) + '/../spec_helper'

describe Customer do
  before(:each) do
    @customer = Customer.new
  end

  it "should have many invoices" do
    @customer.should have_many(:invoices)
  end

  it "should validate presence of customer name" do
    @customer.should validate_presence_of(:name)
  end

  it "should belong to a business" do
    @customer.should belong_to(:business)
  end

end
