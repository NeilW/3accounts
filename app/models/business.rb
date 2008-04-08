class Business < ActiveRecord::Base

  has_many :customers
  has_many :invoices, :through => :customers

  validates_presence_of(:name)

end
