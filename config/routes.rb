#    3accounts - Accounts software for real people 
#    Copyright (C) 2008, Neil Wilson, Aldur Systems
#
#    This file is part of 3accounts
#
#    3accounts is free software: you can redistribute it and/or modify it
#    under the terms of the GNU Affero General Public License as published
#    by the Free Software Foundation, either version 3 of the License,
#    or (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#    Affero General Public License for more details.
#
#    You should have received a copy of the GNU Affero General
#    Public License along with this program.  If not, see
#    <http://www.gnu.org/licenses/>.
#

ActionController::Routing::Routes.draw do |map|

  map.resources :journals, :has_one => :period

  map.resources :businesses

  map.resources :customers

  map.resources :invoices

  map.resource :ledgers

  map.namespace :rates do |rates|
    rates.resources :corporation_tax
  end

  valid_eu_country = '((?i)AT|BE|BG|CY|CZ|DE|DK|EE|EL|ES|FI|FR|GB|HU|IE|IT|LT|LU|LV|MT|NL|PL|PT|RO|SE|SI|SK)'
  eu_vat_picture = '[\w\+\*]{2,12}'
  active_vat_url = 'active_eu_vat_numbers'
  vat_conditions = { 
    :controller => 'vat_numbers', :action => 'show',
    :conditions => {:method => :get},
    :identifier => /#{valid_eu_country}#{eu_vat_picture}/i
  }
  nested_vat_conditions = vat_conditions.merge(
    :country_code => /#{valid_eu_country}/i,
    :identifier => /#{eu_vat_picture}/i
  )
  map.with_options nested_vat_conditions do |nv|
    nv.vat_validity "#{active_vat_url}/:country_code/:identifier"
    nv.formatted_vat_validity "#{active_vat_url}/:country_code/:identifier.:format"
  end
  map.with_options vat_conditions do |vc|
    vc.connect "#{active_vat_url}/:identifier"
    vc.connect "#{active_vat_url}/:identifier.:format"
  end

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
end
