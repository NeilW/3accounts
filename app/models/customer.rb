class Customer < ActiveRecord::Base
  has_many :invoices
  belongs_to :business

  validates_presence_of(:name) 
end
