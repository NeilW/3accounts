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
      result = @@vat_check_driver.checkVat(:countryCode => country_code, :vatNumber => identifier)
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
