class Invoice < ActiveRecord::Base

  has_many :line_items
  belongs_to :customer

  validates_uniqueness_of :number, :case_sensitive => false
  validates_presence_of :number, :tax_point
  validates_existence_of :customer
  validates_associated :line_items

  protected

  def validate
    has_line_items
  end

  def has_line_items
    errors.add(:line_items, "does not exist") if line_items.blank? 
  end

end
