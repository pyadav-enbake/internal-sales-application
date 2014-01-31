RomarCabinates::Application.routes.draw do



  namespace :rcadmin do
    put '/quotes/:id/categories/:category_id', to: 'quote#remove_category', as: 'remove_quote_category'
    resources :countertop_designs
    resources :cabinet_types
    resources :subcategories
    resources :contractors
    resources :customers
    resources :email_templates
    resources :faqs
    resources :faq_categories
    resources :static_pages
  end


  resources :home
  match '/quick_quote' => "home#quick_quote",:via=>'post'
  match '/mycart' => "carts#mycart",:via=>'get'
  match ':action', :controller => "home",:via=>'get'
  match '/update_cart' => "carts#update_cart",:via=>'post'
 # match ':action', :controller => "carts",:via=>'post'
  match '/clearcart/:id' => "carts#clear_cart",:via=>'get'
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
	root "home#index"
	#root "rcadmin/public#index"
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
	delete 'rcadmin/administrators/destroy/:id' => 'rcadmin/administrators#destroy'
	get '/rcadmin/catdimen_name' => 'rcadmin/public#category_dimension_name'
	get '/rcadmin/dc_name' => 'rcadmin/public#dc_name'
	get '/rcadmin/subcat' => 'rcadmin/public#subcat'
	get '/rcadmin/createquote' => 'rcadmin/quote#index',:as => 'create_quote'
	get '/rcadmin/quote/category' => 'rcadmin/quote#show_category',:as => 'select_quote_category'
	get '/rcadmin/quote/product' => 'rcadmin/quote#show_product',:as => 'select_quote_product'
  post '/rcadmin/quote/product' => 'rcadmin/quote#show_product'
	post '/save_customer_deatils' => 'rcadmin/quote#save_customer_deatils'
	post 'save_category_deatils' => 'rcadmin/quote#save_category_deatils'
	post '/rcadmin/quote/send_quote' => 'rcadmin/quote#send_quote'
	post '/rcadmin/quote/resend_quote' => 'rcadmin/quote#resend_quote'
	get '/rcadmin/quote/cabinet_selection' => 'rcadmin/quote#show_cabinet_selection'
	post '/rcadmin/quote/save_cabinet' => 'rcadmin/quote#save_cabinet'
	get '/rcadmin/quote/countertop_design' => 'rcadmin/quote#show_countertop_design'
	post '/rcadmin/quote/save_countertop' => 'rcadmin/quote#save_countertop'
	post '/quote/get_customer' => 'rcadmin/quote#get_customer'
	get '/quote/new_customer' => 'rcadmin/quote#get_new_customer'
	get '/quote/old_customer' => 'rcadmin/quote#get_old_customer'
	post '/rcadmin/quote/add_new_room' => 'rcadmin/quote#add_new_room'
  get '/rcadmin/display_quotes' => 'rcadmin/quote#display_quotes'
  get '/rcadmin/show' => 'rcadmin/quote#show'
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
