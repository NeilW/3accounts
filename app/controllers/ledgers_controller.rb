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

class LedgersController < ApplicationController
  layout 'filings'

  # GET /ledgers/
  def show
    @ledger = Ledger.find(:first)
    @journals = @ledger && @ledger.journals.paginate(:page => params[:page], :order => 'org_id', :per_page => 5)
    unless @journals
      flash[:error] = "You need to load some Journals first"
      redirect_to new_ledgers_url
    end
  end

  # GET /ledgers/new
  def new
    if Ledger.find(:first)
      flash[:error] = "Journals already loaded. If you want to replace them, please delete the current set first."
      redirect_to ledgers_url
    else
      @ledger = Ledger.new
    end
  end

  # DELETE /ledgers
  def destroy
    ledger = Ledger.find(params[:id])
    ledger.destroy
    respond_to do |format|
      format.html { redirect_to new_ledgers_url}
    end
  end


  # POST /ledgers/
  def create
    file = params[:ledger] && params[:ledger][:upload_file]
    number_of_journals = Ledger.load_journals(
      Qb6JournalFile.new(file)
    )
    if number_of_journals.zero?
      flash[:error] = "No journals loaded from file. Have you already loaded them or picked the wrong file?"
      redirect_to new_ledgers_url
    else
      flash[:notice] = "#{handle_singular(number_of_journals, 'Journal')} uploaded."
      redirect_to ledgers_url
    end
  rescue ArgumentError
    flash[:error] = "Please select a file containing Journals"
    redirect_to new_ledgers_url
  end

  protected

  def handle_singular(number, word)
    if number == 1
      "#{number} #{word.singularize}"
    else
      "#{number} #{word.pluralize}"
    end
  end

end
