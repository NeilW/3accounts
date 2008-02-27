class LineItem < ActiveRecord::Base

  belongs_to :invoice
  validates_presence_of(:quantity, :rate)

  def vat
    if rate
      (rate * quantity * vat_rate).truncate(3)
    end
  end

  def total
    if rate
      rate * quantity + vat
    end
  end

end
