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

class Period < ActiveRecord::Base
  belongs_to :journal
  validates_uniqueness_of :journal_id
  validates_presence_of :start_at
  validates_presence_of :end_at
  validates_existence_of :journal

protected
  def validate
    errors.add_to_base("start_at must be before end_at") unless has_sequential_dates?
  end

  private
  def has_sequential_dates?
    end_at && start_at && end_at > start_at
  end

end
