#    3accounts - Accounts software for real people 
#    Copyright (C) 2008, Neil Wilson, Aldur Systems
#
#    This file is part of 3accounts
#
#    3accounts is free software: you can redistribute it and/or modify it
#    under the terms of the GNU Affero General Public License as published
#    by the Free Software Foundation, either version 3 of the License,
#    or (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#    Affero General Public License for more details.
#
#    You should have received a copy of the GNU Affero General
#    Public License along with this program.  If not, see
#    <http://www.gnu.org/licenses/>.
#

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
