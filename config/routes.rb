RomarCabinates::Application.routes.draw do
  namespace :rcadmin do
    resources :products
  end

  namespace :rcadmin do
    resources :dimensions
  end

  namespace :rcadmin do
    resources :dimension_categories
  end

  namespace :rcadmin do
    resources :categories
  end

  namespace :rcadmin do
    resources :login_logs
  end

	root "rcadmin/public#index"
	namespace :rcadmin do
		get "/admins" => "devise/resistrations#new"
		
		
	end
	namespace :rcadmin do
		resources :dashboard
		resources :public
		resources :administrators

	end

	get "/admins/sign_out" => 'rcadmin/public#destroy'
	devise_for :admins, :class_name => "Rcadmin::Admin"
	get 'admins/dashboard' => 'rcadmin/dashboard#index',:as=> 'dashboard_url'
	get 'rcadmin/administrators/destroy/:id' => 'rcadmin/administrators#destroy'
	get '/rcadmin/catdimen_name' => 'rcadmin/public#category_dimension_name'
	get '/rcadmin/dc_name' => 'rcadmin/public#dc_name'


#authenticated :admins do
# devise_scope :admins do
 #   root  "dashboard#index", :as => "profile"
 # end
#end

#unauthenticated :rcadmin do
 # devise_scope :admins  do
    #root "devise/registrations#new", :as => "unauthenticated"
  #end
#end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
