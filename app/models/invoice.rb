class Invoice < ActiveRecord::Base

  has_many :line_items
  belongs_to :customer

  validates_uniqueness_of :number, :case_sensitive => false
  validates_presence_of :number, :tax_point, :customer_id

end
