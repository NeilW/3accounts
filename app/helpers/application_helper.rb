# 3Accounts - Accounts management and compliance
# Copyright (C) 2007 Neil Wilson, Aldur Systems Ltd 
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
module ApplicationHelper
  
  # Show the local time
  def tz(time_at)
    TzTime.zone.utc_to_local(time_at.utc)
  end
  
  # The URL of the discussion group.
  def group_url
    "http://groups.google.com/group/3accounts"
  end

  # The URL of the project management page
  def dev_url
    "http://dev.3accounts.co.uk"
  end
  
end
