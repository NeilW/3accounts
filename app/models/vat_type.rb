class VatType < ActiveRecord::Base

  validates_uniqueness_of(:name)
  validates_presence_of(:rate)
  validates_inclusion_of :rate, :in => 0..1,
    :message => "is outside the range 0 to 1"


end
