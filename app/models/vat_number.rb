module EU
  MEMBER_STATES_COUNTRY_CODES = 
    %w(AT BE BG CY CZ DE DK EE EL ES FI FR GB HU IE IT LT LU LV MT
    NL PL PT RO SE SI SK)
  MEMBER_STATES_VAT_PICTURES = {
    "AT" => /U\d{9}/,
    "BE" => /0\d{9}/,
    "BG" => /\d{9,10}/,
    "CY" => /\d{8}[A-Z]/,
    "CZ" => /\d{8,10}/,
    "DE" => /\d{9}/,
    "DK" => /(\d\d ?){4}/,
    "EE" => /\d{9}/,
    "EL" => /\d{9}/,
    "ES" => /\w\d{7}\w/,
    "FI" => /\d{8}/,
    "FR" => /\w\w ?\d{9}/,
    "GB" => /GD\d\d\d|HA\d\d\d|\d{3} ?\d{4} ?\d\d( \d{3})?/,
    "HU" => /\d{8}/,
    "IE" => /\d[\w\+\*]\d{5}[A-Z]/,
    "IT" => /\d{11}/,
    "LT" => /\d{9}|\d{12}/,
    "LU" => /\d{8}/,
    "LV" => /\d{11}/,
    "MT" => /\d{8}/,
    "NL" => /\d{9}B\d\d/,
    "PL" => /\d{10}/,
    "PT" => /\d{9}/,
    "RO" => /\d{2,10}/,
    "SE" => /\d{12}/,
    "SI" => /\d{8}/,
    "SK" => /\d{10}/
  }
end

class VatNumber < ActiveRecord::Base

  validates_inclusion_of :country_code, 
    :in => EU::MEMBER_STATES_COUNTRY_CODES,
    :message => 'not a valid EU country code'

    validates_each :identifier do |record, attr_name, value|
      value = value.to_s.dup
      if :country_code
        eu_country_code = record.send(:country_code)
      end
      eu_country_code ||= value.slice!(0..1)
      record.errors.add(attr_name, "not in the correct format to be a VAT number") unless value =~ EU::MEMBER_STATES_VAT_PICTURES[eu_country_code]
    end

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
      result.valid == "true" if result
    end
  end

  private

  require "soap/wsdlDriver"
  def create_vat_check_driver
    wsdl = "http://ec.europa.eu/taxation_customs/vies/api/checkVatPort?wsdl"
    SOAP::WSDLDriverFactory.new(wsdl).create_rpc_driver
  end

end
