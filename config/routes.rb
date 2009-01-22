ActionController::Routing::Routes.draw do |map|
  map.resources :posts

  map.connect '/', :controller => 'posts', :action => 'index'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
