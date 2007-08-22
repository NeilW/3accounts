class Category < ActiveRecord::Base
has_many :entries,
          :order => "account_id DESC",
          :dependent => :destroy
validates_presence_of :name
validates_uniqueness_of :name

order_by "name"

end
