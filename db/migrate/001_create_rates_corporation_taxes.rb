class CreateRatesCorporationTaxes < ActiveRecord::Migration
  def self.up
    create_table :corporation_taxes do |t|
      t.integer :fiscal_year_starting
      t.decimal :main_rate, :small_companies_rate, :precision => 3,
        :scale => 0
      t.decimal :mscr_lower_limit, :mscr_upper_limit, :precision => 8,
        :scale => 0
      t.timestamps
    end

    say_with_time "Adding corporation tax static records" do
      Rates::CorporationTax.create :fiscal_year_starting => 2006,
        :main_rate => 30,
        :small_companies_rate => 19,
        :mscr_lower_limit => 300000,
        :mscr_upper_limit => 1500000

      Rates::CorporationTax.create :fiscal_year_starting => 2007,
        :main_rate => 30,
        :small_companies_rate => 20,
        :mscr_lower_limit => 300000,
        :mscr_upper_limit => 1500000
    end

  end

  def self.down
    drop_table :corporation_taxes
  end
end
