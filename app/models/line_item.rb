class LineItem < ActiveRecord::Base

  belongs_to :invoice
  belongs_to :vat_type
  validates_presence_of(:quantity, :rate)

  def sub_total
    rate * quantity if values_available?
  end

  def vat_rate
    vat_type && vat_type.rate
  end

  def vat
    self[:vat] ||
      if values_available?
        (sub_total * vat_rate).truncate(3)
      end
  end

  def total
    sub_total + vat if values_available?
  end

  protected

  def values_available?
    rate
  end

end
