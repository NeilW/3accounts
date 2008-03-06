# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  before_filter :get_business

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '10d66c0f9a697062dae231e99ae747ea'

  protected

  def get_business
    @current_business = Business.find(:first)
  end

end
