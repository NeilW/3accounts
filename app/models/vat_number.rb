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

class VatNumber < ActiveRecord::Base

  validates_as_eu_vat_number :identifier, :with => :country_code

  attr_accessible :identifier, :country_code

  #Strip white space and rubbish from Vat identifier and force to
  #uppercase
  def identifier=(new_value)
    self[:identifier] = new_value && new_value.to_s.gsub(/[^\w\+\*]/,'').upcase
  end

  # Force country code to uppercase
  def country_code=(new_value)
    self[:country_code] = new_value && new_value.to_s.upcase
  end

  #Use the SOAP checker on the Internet to see if the VAT number is live
  #The driver is created on first use and cached 
  def active?
    if valid?
      @@vat_check_driver ||= create_vat_check_driver
      result = @@vat_check_driver.checkVat(
        :countryCode => country_code,
        :vatNumber => identifier
      )
    end
    result && result.valid == "true"
  end

  private

  require "soap/wsdlDriver"
  def create_vat_check_driver
    wsdl = "http://ec.europa.eu/taxation_customs/vies/api/checkVatPort?wsdl"
    SOAP::WSDLDriverFactory.new(wsdl).create_rpc_driver
  end

end
