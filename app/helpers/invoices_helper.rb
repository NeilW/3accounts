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

module InvoicesHelper

  def field_prefix(item)
    record_type = if item.new_record? then "new" else "existing" end
    "invoice[#{record_type}_lines][]"
  end

  def add_items_link(number_of_items = 5)
    change_items_link("Add #{number_of_items} items", number_of_items)
  end

  def remove_items_link(number_of_items = 5)
    change_items_link("Remove #{number_of_items} items", -number_of_items)
  end

  private

  def change_items_link(link, offset)
    content_tag(:p) do
      link_to_if @invoice.sensible_line_items_size?(offset),
        link,
        "?number_of_line_items="+(@invoice.line_items.size+offset).to_s
    end
  end

end
