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

class FixedAsset < ActiveRecord::Base
  belongs_to :journal
  validates_uniqueness_of(:journal_id)
  validates_presence_of(:bought_for)
  validates_presence_of(:bought_on)
  validates_numericality_of(:bought_for, :greater_than_or_equal_to => 0)
  validates_numericality_of(:sold_for, :greater_than_or_equal_to => 0, :allow_nil => true)
  validates_existence_of :journal

  protected

  def validate
    errors.add_to_base("Date asset sold must not be before date bought") unless has_sequential_dates?
    errors.add_to_base("Date sold and price must both be present") unless has_complete_sale_entry?
  end

  def has_sequential_dates?
    sold_on.nil? || bought_on && sold_on >= bought_on
  end

  def has_complete_sale_entry?
    (sold_for && sold_on) || (sold_for.nil? && sold_on.nil?)
  end

end
