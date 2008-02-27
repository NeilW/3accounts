require File.dirname(__FILE__) + '/../spec_helper'

describe Business do
  before(:each) do
    @business = Business.new
  end

  it "should validate presence of business name" do
    @business.should validate_presence_of(:name)
  end

  it "should have many invoices" do
    @business.should have_many(:invoices)
  end

  it "should have many customers" do
    @business.should have_many(:customers)
  end

end
