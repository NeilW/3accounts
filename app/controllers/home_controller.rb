# Static page generator
class HomeController < ApplicationController
  caches_page :index, :donation

end
