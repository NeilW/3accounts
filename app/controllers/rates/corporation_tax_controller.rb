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

class Rates::CorporationTaxController < ApplicationController

  caches_page :index, :show

  def index
    @ct_rates=Rates::CorporationTax.find(:all)
    respond_to do |format|
      format.html
      format.xml do 
        render_xml_ct_rate("corporation_tax_rates")
      end
    end
  end

  def show
    @ct_rates=Rates::CorporationTax.find_by_fiscal_year_starting(params[:id])
    unless @ct_rates
      render_optional_error_file(:not_found)
    else
      respond_to do |format|
        format.html
        format.xml do 
          render_xml_ct_rate("corporation_tax_rate")
        end
      end
    end
  end

private

  def render_xml_ct_rate(root)
    render :xml => @ct_rates.to_xml(
      :root => root,
      :except => [:id, :updated_at, :created_at],
      :methods => :mscr_fraction
    ) 
  end

end
