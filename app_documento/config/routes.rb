AppDocumento::Application.routes.draw do

  #Ruta de ajax para tabs de show producto
  post "productos/show_documentos"
  post "productos/show_importadores"
  post "productos/show_presentaciones"
  post "importadors/seleccionar_existente"

  post "productos/ocultar" 


  get "documentos/index_usuario" #Documentos por usuario

  get "vencido/index"  #Alertas

  post "productos/ocultar"  #Ocultar producto

  post "documentos/ocultar" #Ocultar documentos

  #POST y GET de tramitar documento (para el correo) 
  post "vencido/tramitar_documento"
  get  "vencido/tramitar_documento"

  post "vencido/activar_alerta"

  #POST y GET de desactivar alerta (para el correo) 
  post "vencido/desactivar_alerta"
  get "vencido/desactivar_alerta"


  #Enrutamiento para los logs
  get "logsesions/index"

  get "logtramite/index"

  get "logsolicitud/index"

  get "logdocumento/index"

  get "logproductos/index"

  get "logsesions/show_by_user"

  get "logdocumento/show_by_user"

  get "logtramite/show_by_user"

  get "logproductos/show_by_user"

  get "inicio/index"


  # Autenticacion de usuarios
  devise_for :usuarios


  #Enrutamiento sobre modelo de Usuario
  resources :usuarios do
    collection do 
      put :update_password
      post :recover_password
      post :asignar_cliente
      get :edit_password
      get :ask_password
      get :send_password
      get :new_asignar_cliente
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

  #Enrutamiento sobre el modelo documento
  resources :documentos do
    collection do
      post :generar_tramitado
    end
  end

  #Enrutamiento sobre el modelo presentacion
  resources :presentacions

  #Enrutamiento sobre el modelo importador
  resources :importadors

  #Enrutamiento sobre el modelo requisito
  resources :requisitos

  #Root path
  root :to => 'inicio#index', :as => :home # Hace posible usar home_path


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
