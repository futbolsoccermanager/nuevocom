Nuevocom::Application.routes.draw do



  resources :informacion

  match "estadisticas/dato_jugador/:jugador_id" => "estadisticas#dato_jugador", :as => :estadistica_jugador

  resource :messages

  resources :usuarios do
    collection do
      match 'search' => 'usuarios#search_usuario', :as => :search
      match 'list' => 'usuarios#lista_usuarios', :as => :list
      match 'seguir/:usuario_id' => 'usuarios#seguir_usuario', :as => :seguir
    end
  end

  resources :mercado do
    match "buscar" => 'mercado#buscarjugador', :as => :buscarjugador
    match "peticion" => 'mercado#peticion_jugador', :as => :peticion
  end
  post "mercado/create_ofertas"
  match "mercado/:id_seleccion/index" => 'mercado#index', :as => :mercado

  devise_for :users

  get "home/index"
  get "home/hablandoencuero"

  match "home/prueba" => 'home#prueba', :as => :prueba
  match "home/prueba_post" => 'home#prueba_post', :as => :prueba_post, :only => [:post]

  resource :selecciones do
    match 'change/:id_seleccion' => 'selecciones#change_seleccion', :as => :change
    match 'plantilla/:id_seleccion' => 'selecciones#plantilla', :via => [:get], :on => :collection, :as => :plantilla
    match 'save_once_titular' => 'selecciones#save_once_titular', :via => [:put], :on => :collection, :as => :save_once_titular
    match 'cambiar_tactica/:tactica/:id_seleccion' => 'selecciones#cambiar_tactica', :via => [:put], :on => :collection, :as => :cambiar_tactica
  end
  resource :ligas do
    match 'joinleague' => 'ligas#join_liga', :as => :join, :only => [:get]
    match 'leagues/:tipo' => 'ligas#search_league', :as => :search
    match 'list_leagues' => 'ligas#list_leagues', :as => :list
  end

  resources :ofertas

  namespace :api do
    resources :token, :only => [:create, :destroy]
  end

  resources :clasificacion

  namespace :admin do
    resource :puntuaciones do
      match "puntos_equipos(/jornada/:jornada)" => 'puntuaciones#puntos_equipos', :as => :puntos_equipos
      match "cambiar_puntos" => 'puntuaciones#cambiar_puntos', :as => :cambiar_puntos

    end
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
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
