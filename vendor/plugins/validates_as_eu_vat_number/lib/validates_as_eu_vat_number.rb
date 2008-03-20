# Validates as EU VAT number. Checks the value supplied against the picture
# for the appropriate country.

# Constants representing the ISO country codes for the EU member states
# and the RegExp pictures of their VAT numbers. Derived from the UK HMRC
# guide "EC Country Codes and customer VAT Number formats"
module EU
  MEMBER_STATES_COUNTRY_CODES = 
    %w(AT BE BG CY CZ DE DK EE EL ES EU FI FR GB HU IE IT LT LU LV MT
    NL PL PT RO SE SI SK).freeze
  MEMBER_STATES_VAT_PICTURES = {
    "AT" => /\AU\d{8}\Z/,
    "BE" => /\A0\d{9}\Z/,
    "BG" => /\A\d{9,10}\Z/,
    "CY" => /\A\d{8}[A-Z]\Z/,
    "CZ" => /\A\d{8,10}\Z/,
    "DE" => /\A\d{9}\Z/,
    "DK" => /\A(\d\d ?){4}\Z/,
    "EE" => /\A\d{9}\Z/,
    "EL" => /\A\d{9}\Z/,
    "ES" => /\A[A-Z\d]\d{7}[A-Z\d]\Z/,
    "EU" => /\A\d{9}\Z/,
    "FI" => /\A\d{8}\Z/,
    "FR" => /\A[A-HJ-NP-Z\d]{2} ?\d{9}\Z/,
    "GB" => /\AGD\d{3}\Z|\AHA\d{3}\Z|\A\d{3} ?\d{4} ?\d\d( ?\d{3})?\Z/,
    "HU" => /\A\d{8}\Z/,
    "IE" => /\A[7-9][A-Z\d\+\*]\d{5}[A-W]\Z/,
    "IT" => /\A\d{11}\Z/,
    "LT" => /\A\d{9}\Z|\A\d{12}\Z/,
    "LU" => /\A\d{8}\Z/,
    "LV" => /\A\d{11}\Z/,
    "MT" => /\A\d{8}\Z/,
    "NL" => /\A\d{9}B\d\d\Z/,
    "PL" => /\A\d{10}\Z/,
    "PT" => /\A\d{9}\Z/,
    "RO" => /\A\d{2,10}\Z/,
    "SE" => /\A\d{12}\Z/,
    "SI" => /\A\d{8}\Z/,
    "SK" => /\A\d{10}\Z/
  }.freeze
end


module ActiveRecord
  module Validations
    module ClassMethods
      # Validates whether the value of the specified attribute is in
      # the correct form by matching it against the VAT picture for the
      # appropriate country.
      #
      #   class Person < ActiveRecord::Base
      #     validates_as_eu_vat_number :identifier, :with => :country_code
      #     validates_as_eu_vat_number :full_vat_number
      #   end
      #
      #
      # Configuration options:
      # * <tt>message</tt> - A custom error message (default is: "is invalid")
      # * <tt>with</tt> - Either a symbol referencing a field with the country code, or the code itself as a String.
      # * <tt>on</tt> Specifies when this validation is active (default is :save, other options :create, :update)
      # * <tt>allow_nil</tt> - Skip validation if attribute is nil.
      # * <tt>allow_blank</tt> - Skip validation if attribute is blank.
      # * <tt>if</tt> - Specifies a method, proc or string to call to determine if the validation should
      #   occur (e.g. :if => :allow_validation, or :if => Proc.new { |user| user.signup_step > 2 }).  The
      #   method, proc or string should return or evaluate to a true or false value.
      # * <tt>unless</tt> - Specifies a method, proc or string to call to determine if the validation should
      #   not occur (e.g. :unless => :skip_validation, or :unless => Proc.new { |user| user.signup_step <= 2 }).  The
      #   method, proc or string should return or evaluate to a true or false value.
      def validates_as_eu_vat_number(*attr_names)
        configuration = { :message => ActiveRecord::Errors.default_error_messages[:invalid], :on => :save, :with => nil }
        configuration.update(attr_names.extract_options!)

        validates_each(attr_names, configuration) do |record, attr_name, value|
          value = value.to_s.dup
          country_reference = configuration[:with]
          if country_reference
            eu_country_code = record.send(country_reference) if country_reference.is_a?(Symbol)
            eu_country_code = country_reference if country_reference.is_a?(String)
          end
          eu_country_code ||= value.slice!(0..1)
          eu_country_code.upcase!
          unless EU::MEMBER_STATES_COUNTRY_CODES.include?(eu_country_code) &&
            value =~ EU::MEMBER_STATES_VAT_PICTURES[eu_country_code] 
            record.errors.add(attr_name, configuration[:message])
          end
        end
      end
      
    end
  end
end
