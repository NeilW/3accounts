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

class VatNumbersController < ApplicationController

  skip_before_filter :get_business

  def show
    if params[:identifier] 
      params[:country_code] ||= params[:identifier].slice!(0..1)
    end
    temp_vat_number = VatNumber.new(params)
    respond_to do |format|
      if !temp_vat_number.valid?
        format.html { render :text => '<h1>Malformed VAT Number</h1>', 
          :status => :unprocessable_entity }
        format.xml { render :xml => temp_vat_number.errors,
          :status => :unprocessable_entity }
      elsif temp_vat_number.active?
        format.html { render :text => '<h1>Active</h1>' }
        format.xml do
          render :xml => temp_vat_number.to_xml(:except => [:created_at, :updated_at]) {|xml| xml.active true }
        end
      else
        format.html { render :text => '<h1>Not Found</h1>',
          :status => :not_found }
        format.xml { head :not_found }
      end
    end
  end

end
