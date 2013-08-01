AppDocumento::Application.routes.draw do  get "vencido/index"
  
  post "productos/ocultar" 

  post "vencido/tramitar_documento"

  get  "vencido/tramitar_documento"
  
  post "vencido/activar_alerta"
  
  get "vencido/activar_alerta"
  
  post "vencido/desactivar_alerta"

  get "vencido/desactivar_alerta"

  get "logtramite/index"

  get "logsolicitud/index"

  get "logdocumento/index"

  resources :logproductos

  devise_for :usuarios 

  get "inicio/index"

  #Enrutamiento sobre modelo de Usuario
  resources :usuarios do
    collection do 
      put :update_password
      post :recover_password
      get :edit_password
      get :ask_password
      get :send_password
    end
  end

  #Enrutamiento sobre modelo producto
  resources :productos do
    collection do
      post :prov_filter
      post :type_filter
      post :marca_filter
      get  :productos_usuario
    end
  end

  #Enrutamiento sobre modelo tramite
  resources :tramites do 
    collection do 
        put  :check
        post :update_requisitos
        get :tramites_usuario
    end
  end

  root :to => 'inicio#index', :as => :home # Hace posible usar home_path

  #Redirecciona locale (en/es) al index
  match '/:locale' => 'inicio#index'

  #Alcance de locale
  scope "(:locale)", :locale => /en|es/ do

    resources :presentacions


    resources :documentos


    resources :requisitos


    resources :logs


    resources :tramites


    resources :importadors


    resources :productos


    resources :usuarios

  end


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
