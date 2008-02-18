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
  end

  def self.down
    drop_table :corporation_taxes
  end
end
