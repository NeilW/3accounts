class Entry < ActiveRecord::Base
  belongs_to :account
  belongs_to :category
  validates_presence_of :value
  validates_presence_of :effective_date
end
