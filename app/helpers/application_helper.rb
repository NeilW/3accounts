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

# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def classify_link_if_current(link_text, options = {}, html_options = {})
    html_options.reverse_merge! :class => "current" if current_page?(options)
    link_to(link_text, options, html_options)
  end

  def display_error_messages
    html = ""
    if flash[:notice]
      html << content_tag(:div,
                  content_tag(:p, h(flash[:notice])),
                  :class => 'message success', :id => 'notice')
    end
    if flash[:error]
      html << content_tag(:div,
                  content_tag(:p, h(flash[:error])),
                  :class => 'message failure', :id => 'error')
    end
    html
  end

  Time::DATE_FORMATS[:uk] = "%d-%b-%y"

end
