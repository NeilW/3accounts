# Constants representing the ISO country codes for the EU member states
# and the RegExp pictures of their VAT numbers
module EU
  MEMBER_STATES_COUNTRY_CODES = 
    %w(AT BE BG CY CZ DE DK EE EL ES FI FR GB HU IE IT LT LU LV MT
    NL PL PT RO SE SI SK).freeze
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
  }.freeze
end


module ActiveRecord
  module Validations
    module ClassMethods
      # Validates whether the value of the specified attribute is of
      # the correct form by matching it against the VAT picture for the appropriate country
      # provided.
      #
      #   class Person < ActiveRecord::Base
      #     validates_as_eu_vat_number :identifier, :with => :country_code
      #     validates_as_eu_vat_number :full_vat_number
      #   end
      #
      # A regular expression must be provided or else an exception will be raised.
      #
      # Configuration options:
      # * <tt>message</tt> - A custom error message (default is: "is invalid")
      # * <tt>with</tt> - Either a symbol referencing a field with the country code, or the code itself as a String.
      # * <tt>on</tt> Specifies when this validation is active (default is :save, other options :create, :update)
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
