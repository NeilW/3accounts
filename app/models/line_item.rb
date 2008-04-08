class LineItem < ActiveRecord::Base

  belongs_to :invoice
  belongs_to :vat_type
  validates_presence_of(:quantity, :rate)
  validates_numericality_of :quantity, :greater_than => 0, 
    :message => "must be a positive amount."

  def sub_total
    rate * quantity if values_available?
  end

  def vat_rate
    vat_type.rate if handling_vat?
  end

  # UK Vat rules allow you to round down to the nearest 0.1p 
  # at line item level.
  def vat
    clear_vat_cache unless handling_vat?
    if self[:vat].nil? && handling_vat? && values_available?
      (sub_total * vat_rate).truncate(3)
    else
      self[:vat] 
    end
  end

  def vat=(amount)
    if handling_vat?
      self[:vat] = amount
    else
      clear_vat_cache
    end
  end

  def total
    total = sub_total
    total += vat if handling_vat?
    total
  end

  def handling_vat?
    vat_type
  end

  protected

  def values_available?
    rate
  end

  def clear_vat_cache
    self[:vat] = nil
  end


end
