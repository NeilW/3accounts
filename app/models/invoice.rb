class Invoice < ActiveRecord::Base

  has_many :line_items, :dependent => :destroy
  belongs_to :customer

  validates_uniqueness_of :number, :case_sensitive => false
  validates_presence_of :number, :issued_at
  validates_existence_of :customer
  validates_associated :line_items

  def sub_total
    line_items.inject(0) do |total, item|
      total + item.sub_total
    end
  end

  # UK Vat rules state that you should round down to nearest penny
  # at invoice level.
  def vat
    line_items.inject(BigDecimal.new("0")) do |total, item|
      vat_amount = item.vat
      total += vat_amount if vat_amount
      total
    end.truncate(2)
  end

  def total
    sub_total + vat
  end

  protected

  def validate
    has_line_items
    has_all_vat_filled_in_or_blank
  end

  def has_line_items
    errors.add(:line_items, "does not exist") if line_items.blank? 
  end

  def has_all_vat_filled_in_or_blank
    vat_types = line_items.collect do |item|
      item.vat_type_id
    end
    errors.add(:line_items,
      "all vat types must exist, or all must be blank"
             ) unless vat_types.all? {|item| item } ||
                 vat_types.all? {|item| item.nil? }
  end


end
