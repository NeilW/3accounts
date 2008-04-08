class Transaction < ActiveRecord::Base
  belongs_to :journal
end
