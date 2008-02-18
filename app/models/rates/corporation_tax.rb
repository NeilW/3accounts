class Rates::CorporationTax < ActiveRecord::Base

  validates_inclusion_of :main_rate, :small_companies_rate, :in => 1..100
  validates_numericality_of :fiscal_year_starting, :small_companies_rate, :main_rate, :mscr_lower_limit, :mscr_upper_limit, :integer_only => true
  validates_presence_of :fiscal_year_starting, :small_companies_rate, :main_rate, :mscr_lower_limit, :mscr_upper_limit

  def mscr_fraction
    if valid?
      mscr_lower_limit * (main_rate - small_companies_rate).to_f / 
        (mscr_upper_limit - mscr_lower_limit).to_f /
        100.0
    end
  end

  def validate
    if main_rate && small_companies_rate && main_rate < small_companies_rate
      errors.add_to_base("Main Rate should be >= Small Companies Rate") 
    end
    if mscr_lower_limit && mscr_upper_limit && mscr_lower_limit > mscr_upper_limit
      errors.add_to_base("MSCR upper limit should be >= lower limit") 
    end
    if fiscal_year_starting && fiscal_year_starting < 2006
      errors.add_to_base("Fiscal years before 2006 not supported")
    end
  end

end
