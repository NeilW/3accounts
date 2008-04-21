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

class AssetsController < ApplicationController

  before_filter :get_journal

  def create
    if @journal.fixed_asset
      flash[:error] = "Fixed Asset record already exists"
    else
      @journal.fixed_asset = FixedAsset.new(
        :bought_for => @journal.original_cost,
        :bought_on => @journal.posted_at
      )
      if @journal.save
        flash[:notice] = "Fixed Asset record created"
      else
        flash[:error] = "Failed to create asset record"
      end
    end
    respond_to do |format|
      format.html {redirect_to bills_path}
    end
  end

  def destroy
    if @journal.fixed_asset.nil?
      flash[:error] = "Fixed Asset record missing"
    else
      @journal.fixed_asset.destroy
      flash[:notice] = "Fixed Asset record removed"
    end
    respond_to do |format|
      format.html {redirect_to bills_path}
    end
  end

  protected

  def get_journal
    @journal = Journal.find(params[:bill_id])
  end

end
