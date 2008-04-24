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

class PeriodicsController < ApplicationController
  layout 'filings'

  # GET /periodics
  def index
    @ledger = Ledger.find(:first)
    @journals = @ledger && @ledger.periodic_journals.paginate(:page => params[:page], :order => 'posted_at', :per_page => 5)
    unless @journals
      flash[:error] = "You need to load some journals first"
      redirect_to new_ledgers_url
    end
  end

end
