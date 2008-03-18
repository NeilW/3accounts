ActionController::Routing::Routes.draw do |map|
  map.resources :businesses

  map.resources :customers

  map.resources :invoices

  map.namespace :rates do |rates|
    rates.resources :corporation_tax
  end

  valid_eu_country = '(AT|BE|BG|CY|CZ|DE|DK|EE|EL|ES|FI|FR|GB|HU|IE|IT|LT|LU|LV|MT|NL|PL|PT|RO|SE|SI|SK)'
  eu_vat_picture = '\w{2,12}'
  map.vat_validity 'vat_validity/:country_code/:vat_number',
    :controller => 'vat_checker', :action => 'show',
    :requirements => {
      :country_code => /#{valid_eu_country}/,
      :vat_number => /#{eu_vat_picture}/
    }
  map.connect 'vat_validity/:vat_number',
    :controller => 'vat_checker', :action => 'show',
    :requirements => {
      :vat_number => /#{valid_eu_country}#{eu_vat_picture}/
    }

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
