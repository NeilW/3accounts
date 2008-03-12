class Invoice < ActiveRecord::Base

  has_many :line_items, :dependent => :destroy
  belongs_to :customer
  after_update :save_line_items

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

  def build_requested_number_of_line_items(amount)
    self.line_items.clear
    make_up_requested_number_of_line_items(amount)
  end

  def make_up_requested_number_of_line_items(amount)
    lines_required = calculate_lines_required(amount.to_i)
    lines_required.times do
      line_items.build
    end
  end

  def sensible_line_items_size?(offset)
    sensible_line_items_range.include?(line_items.size+offset)
  end
    

  def new_lines=(invoice_lines)
    invoice_lines.each do |line|
      unless form_line_blank?(line)
        line_items.build(line)
      end
    end
  end

  def existing_lines=(invoice_lines)
    line_items.each do |line|
      next if line.new_record?
      details = invoice_lines[line.id.to_s]
      if details && !form_line_blank?(details)
        line.attributes = details
      else
        line_items.delete(line)
      end
    end
  end

  protected

  DEFAULT_NUMBER_OF_LINE_ITEMS = 3
  MAX_NUMBER_OF_LINE_ITEMS = 20

  def sensible_line_items_range
    [line_items.count, DEFAULT_NUMBER_OF_LINE_ITEMS].max..MAX_NUMBER_OF_LINE_ITEMS
  end

  def save_line_items
    line_items.each do |item|
      item.save(false)
    end
  end

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

  # +form_line+ must be a hash
  def form_line_blank?(form_line)
    form_line.values.join.blank?
  end

  # +amount+ must be a number.
  def calculate_lines_required(amount)
    if amount < DEFAULT_NUMBER_OF_LINE_ITEMS
      amount = DEFAULT_NUMBER_OF_LINE_ITEMS
    elsif amount > MAX_NUMBER_OF_LINE_ITEMS
      amount = MAX_NUMBER_OF_LINE_ITEMS
    end
    lines_required = amount - line_items.size
  end

end
