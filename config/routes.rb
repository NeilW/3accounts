ActionController::Routing::Routes.draw do |map|

#  - add an observer to config/environment.rb
#    config.active_record.observers = :user_observer

#  map.open_id_complete 'session', :controller => "session", :action => "create", :requirements => { :method => :get }

  map.resources :users
  map.resource  :session

  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate'

  map.signup '/signup', :controller => 'users', :action => 'new'
  map.login  '/login', :controller => 'session', :action => 'new'
  map.logout '/logout', :controller => 'session', :action => 'destroy'

  #map.connect ':controller/:action/:id.:format'


end
