require File.dirname(__FILE__) + '/spec_helper'

class VatTestRecord < ActiveRecord::Base
  def self.columns; []; end
  attr_accessor :vat_number
  attr_accessor :country
end

class ValidateVatNumberUsingWith < VatTestRecord
  validates_as_eu_vat_number :vat_number, :with => :country
end

class ValidateVatNumberAllowNil < VatTestRecord
  validates_as_eu_vat_number :vat_number, :allow_nil => true
end

class ValidateGBVatNumber < VatTestRecord
  validates_as_eu_vat_number :vat_number, :with => 'gb'
end

VALID_VAT_NUMBERS = %w(
ATU15138205 ATU46080404 ATU61195628 BE0453521619 BE0474840437 BG130544585
BG130736984 CZ26780259 CZ49620819 DE112144487 DE119817125 DK10290813
DK18661306 DK21832073 DK26210895 EE100878938 EE100919295 EL094501040
EL095723304 ESA78109592 ESA79220109 ESB80067358 ESG0061466I FI04695196
FI15408594 FR01712030113 FR64333266765 FR84350934675 FR95483929956
gb123456789 GB123456789012 GB195275334 GB642423951 GB750323267 GB759713196
GB987654321 gbGD123 gbHA456 HU10268492 HU12078503 IE9507061A IE9Y71814N
IT00743110157 IT02087050155 IT08041000012 IT11492960155 LT100002894215
LT290068995116 LU15027442 LU21416127 LV40003638595 LV50003087101
MT15220517 MT17365728 NL001545668B01 NL008810151B01 PL5260000821
PL5261025421 PL6772135826 PT501301135 PT503038083 RO16241790 RO2413020
SE502052817901 SE556043606401 SE556229159001 SI37568833 SI97093726
SK2020133082 SK2020349045
CY12345678A CY87654321Z
EU123456789 EU987654321
) +
  [
    'GB987 6543 21', 'GB842 0753 41', 'gb123 4567 89', 'DK99 99 99 99',
    'FR99 123456789'
  ]

INVALID_VAT_PICTURES = %w(gb1234567890 gb12345678
ATu12345678 ATX12345678 ATU1234567 ATU123456789 ATU1234A678
BE413562567 BE1123456789 BE012345678 BE01234567890 BE01234A6789
BG12345678 BG12345678901 BGA123456789 BG01234A6789
CY1234567X CY123456789X CY123456789 CY12345678j CYA2345678X CY1234567AX
CZ1234567 CZ12345678901 CZ1234A678 CZA23456789 CZ12345678A
DE12345678 DE1234567890 DEA23456789 DE12345678A
DK1234567 DK123456789 DKA2345678 DK1234567A
EE12345678 EE1234567890 EEA23456789 EE12345678A
EL12345678 EL1234567890 ELA23456789 EL12345678A
ESAA234567A ESA123456AA ESa1234567a ESA123456A ESA1234567 ESA12345678A 
ESA123456789 ES1234567890 
EU12345678 EU1234567890 EUA23456789 EU12345678A
FI1234567 FI123456789 FIA2345678 FI1234567Z
FRIX123456789 FROX123456789 FRXI123456789 FRXO123456789
FR0012345678 FRAA1234567890 FR01234567890A FRAAA23456789
FRaa123456789
gb12345678 gb1234567890 gbA23456789 gb12345678A
gb12345678901 gb1234567890123 gb12345678901A gbA23456789012
GBHA12 GBHA1234 GBHAA23 GBHA12A 
GBGD12 GBGD1234 GBGDA23 GBGD12A gbXX123
HU1234567 HU123456789 HUA2345678 HU1234567Z
IE9X123456A IE9X1234A IE6X12345A IEA123456A IE9+12345X 
IE9X123456 IE9a12345A IE9X12345a
IT1234567890 IT123456789012 ITA2345678901 IT1234567890A
LT12345678 LT1234567890 LT12345678901 LT1234567890123
LTA12345678 LT12345678A LTA12345678901 LT12345678901A
LU1234567 LU123456789 LUA2345678 LU1234567Z
LV1234567890 LV123456789012 LVA2345678901 LV1234567890A
MT1234567 MT123456789 MTA2345678 MT1234567Z
NL12345678B12 NL1234567890B12 NL123456789B1 NL123456789B123
NL123456789012 NLA23456789B12 NL12345678AB12 NL123456789BA2
NL123456789B1A NL123456789A12 NL123456789C12 
PL123456789 PL12345678901 PLA234567890 PL123456789A
PT12345678 PT1234567890 PTA23456789 PT12345678A
RO1 RO12345678901 ROAA ROA234567890 RO123456789A
SE12345678901 SE1234567890123 SEA23456789012 SE12345678901A
SI1234567 SI123456789 SIA2345678 SI1234567Z
SK123456789 SK12345678901 SKA234567890 SK123456789A
) +
  ['GB98 765 423 1', 'gb987654321 0', 'DK99 99 99 99 99', 'DK99 99 99']

describe VatTestRecord do

  it "should observe the country code supplied in a with" do
    temp = ValidateVatNumberUsingWith.new(:vat_number => 'FI12345678',
                                          :country => 'GB')
    temp.should have(1).error_on(:vat_number)
  end

  it "should ignore the country code supplied when with is missing" do
    temp = ValidateVatNumberAllowNil.new(:vat_number => 'FI12345678',
                                          :country => 'GB')
    temp.should have(:no).errors_on(:vat_number)
  end

  describe "should not be valid" do
  
    it "when vat_number is nil" do
      temp = ValidateVatNumberUsingWith.new
      temp.should_not be_valid
    end

    it "when country code used is not in EU" do
      temp =ValidateVatNumberUsingWith.new(:vat_number => 'GR123456789')
      temp.should have(1).error_on(:vat_number)
    end

    it "when country code is missing" do
      temp = ValidateVatNumberUsingWith.new(:vat_number => '123456789')
      temp.should have(1).error_on(:vat_number)
    end

  end

  describe "should be valid when " do

    it "vat number is nil and allow nil in place" do
      temp = ValidateVatNumberAllowNil.new
      temp.should be_valid
    end

    it "vat number has a country and no with" do
      temp = ValidateVatNumberAllowNil.new(:vat_number => 'gb123456789')
      temp.should have(:no).errors_on(:vat_number)
    end

    it "country is supplied as a string" do
      temp = ValidateGBVatNumber.new(:vat_number => '123456789')
      temp.should have(:no).errors_on(:vat_number)
    end

    VALID_VAT_NUMBERS.each do |vat_number|
      it "#{vat_number} is provided as a full_vat_number" do
        temp = ValidateVatNumberUsingWith.new(:vat_number => vat_number)
        temp.should have(:no).errors_on(:vat_number)
      end

      it "#{vat_number} is provided as vat_number and country code" do
        temp = ValidateVatNumberUsingWith.new(:vat_number => vat_number.slice(2..-1), :country => vat_number.slice(0..1))
        temp.should have(:no).errors_on(:vat_number)
      end
    end
  end

  describe "should be invalid when" do

    it "vat number has no country and no with" do
      temp = ValidateVatNumberAllowNil.new(:vat_number => '123456789',
                                           :country => 'GB')
      temp.should have(1).error_on(:vat_number)
    end

    INVALID_VAT_PICTURES.each do |vat_number|
      it "#{vat_number} is provided as a full vat_number" do
        temp = ValidateVatNumberUsingWith.new(:vat_number => vat_number)
        temp.should have(1).error_on(:vat_number)
      end

      it "#{vat_number} is provided as vat_number and country code" do
        temp = ValidateVatNumberUsingWith.new(:vat_number => vat_number.slice(2..-1), :country => vat_number.slice(0..1))
        temp.should have(1).error_on(:vat_number)
      end
    end
  end

end
