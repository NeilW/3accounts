class Account < ActiveRecord::Base
  has_many :entries,
            :order => "effective_date DESC, created_at DESC",
            :dependent => :destroy
  validates_presence_of :name
  validates_uniqueness_of :name
end
