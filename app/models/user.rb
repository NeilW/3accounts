class User < ActiveRecord::Base
  include AuthenticatedBase


  validates_uniqueness_of   :login, :email, :case_sensitive => false

  composed_of :tz, :class_name => 'TZInfo::Timezone', :mapping => %w( time_zone time_zone )
  
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :password, :password_confirmation, :indentity_url 

  def to_param
    login
  end

  def self.find_by_param(*args)
    find_by_login *args
  end

  def to_xml
    super( :only => [ :login, :time_zone, :last_login_at ] )
  end
end
