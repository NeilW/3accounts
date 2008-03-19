require 'test/unit'

begin
  require File.dirname(__FILE__) + '/../../../../config/boot'
  require 'active_record'
  require 'validates_as_uk_postcode'
rescue LoadError
  require 'rubygems'
  require_gem 'activerecord'
  require File.dirname(__FILE__) + '/../lib/validates_as_uk_postcode'
end

class TestRecord < ActiveRecord::Base
  def self.columns; []; end
  attr_accessor :postcode
  validates_as_uk_postcode :postcode
end

class ValidatesAsUkPostcodeTest < Test::Unit::TestCase
  def test_invalid_postcodes
    postcodes = [
      'Q1 1AA', 'V1 1AA', 'X1 1AA', 'M1 CAA', 'M1 IAA', 'M1 KAA', 'M1 MAA', 'M1 OAA', 'M1 VAA',

      'Q60 1NW', 'V60 1NW', 'X60 1NW', 'M60 1CW', 'M60 1IW', 'M60 1KW', 'M60 1MW', 'M60 1OW', 
      'M60 1VW', 'M60 1NC', 'M60 1NI', 'M60 1NK', 'M60 1NM', 'M60 1NO', 'M60 1NV', 

      'QR2 6XH', 'VR2 6XH', 'XR2 6XH', 'CI2 6XH', 'CJ2 6XH', 'CZ2 6XH', 'CR2 6CH', 'CR2 6IH',
      'CR2 6KH', 'CR2 6MH', 'CR2 6OH', 'CR2 6VH', 'CR2 6XC', 'CR2 6XI', 'CR2 6XK', 'CR2 6XM',
      'CR2 6XO', 'CR2 6XV',

      'QN55 1PT', 'VN55 1PT', 'XN55 1PT', 'DI55 1PT', 'DJ55 1PT', 'DZ55 1PT', 'DN55 1CT',
      'DN55 1IT', 'DN55 1KT', 'DN55 1MT', 'DN55 1OT', 'DN55 1VT', 'DN55 1PC', 'DN55 1PI',
      'DN55 1PK', 'DN55 1PM', 'DN55 1PO', 'DN55 1PV',

      'Q1A 1HQ', 'V1A 1HQ', 'X1A 1HQ', 'W1I 1HQ', 'W1L 1HQ', 'W1M 1HQ', 'W1N 1HQ', 'W1O 1HQ',
      'W1P 1HQ', 'W1Q 1HQ', 'W1R 1HQ', 'W1V 1HQ', 'W1X 1HQ', 'W1Y 1HQ', 'W1Z 1HQ', 'W1A 1CQ',
      'W1A 1IQ', 'W1A 1KQ', 'W1A 1MQ', 'W1A 1OQ', 'W1A 1VQ', 'W1A 1HC', 'W1A 1HI', 'W1A 1HK',
      'W1A 1HM', 'W1A 1HO', 'W1A 1HV',

      'QC1A 1BB', 'VC1A 1BB', 'XC1A 1BB', 'EI1A 1BB', 'EJ1A 1BB', 'EZ1A 1BB', 'EC1C 1BB',
      'EC1D 1BB', 'EC1F 1BB', 'EC1G 1BB', 'EC1I 1BB', 'EC1J 1BB', 'EC1K 1BB', 'EC1L 1BB',
      'EC1O 1BB', 'EC1Q 1BB', 'EC1S 1BB', 'EC1T 1BB', 'EC1U 1BB', 'EC1Z 1BB', 'EC1A 1IB',
      'EC1A 1MB', 'EC1A 1OB', 'EC1A 1VB', 'EC1A 1BC', 'EC1A 1BI', 'EC1A 1BK', 'EC1A 1BM',
      'EC1A 1BO', 'EC1A 1BV',
      ]
    postcodes.each do |postcode|
      assert !TestRecord.new(:postcode => postcode).valid?, "#{postcode} should be illegal."
      assert !TestRecord.new(:postcode => postcode.downcase).valid?, "#{postcode.downcase} should be illegal."
      assert !TestRecord.new(:postcode => postcode.gsub(' ', '')).valid?, "#{postcode} (with no spaces) should be illegal."
      assert !TestRecord.new(:postcode => postcode.downcase.gsub(' ', '')).valid?, "#{postcode.downcase} (with no spaces) should be illegal."
    end
  end

  def test_valid_postcodes
    postcodes = [
      'M1 1AA',
      'M60 1NW', 
      'CR2 6XH',
      'DN55 1PT',
      'W1A 1HQ',
      'EC1A 1BB',
      'BT9 7JL',
      'GIR 0AA',
      ]
    postcodes.each do |postcode|
      assert TestRecord.new(:postcode => postcode).valid?, "#{postcode} should be legal."
      assert TestRecord.new(:postcode => postcode.downcase).valid?, "#{postcode.downcase} should be legal."
      assert TestRecord.new(:postcode => postcode.gsub(' ', '')).valid?, "#{postcode} (with no spaces) should be legal."
      assert TestRecord.new(:postcode => postcode.downcase.gsub(' ', '')).valid?, "#{postcode.downcase} (with no spaces) should be legal."
    end
  end
end