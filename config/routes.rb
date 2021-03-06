Rails.application.routes.draw do
  resources :surveydata
  resources :comments

  resources :links do
    member do
      put "like", to: "links#upvote"
      put "dislike", to: "links#downvote"
    end
    resources :comments
  end

  root to: "application#games"
  get '/games' => "application#games"
  post '/games' => "application#game_detail"
  get '/games/:game_name' => "application#specific_game"
  get '/ourgames/:game_name' => redirect('/games/%{game_name}')



  devise_for :users, controllers: {registrations: 'registrations', :sessions => "sessions", :omniauth_callbacks => "users/omniauth_callbacks"}#, :path => '', :path_names => { :sign_in => "login", :sign_up => "sign_up"}
  get 'users/:username' => 'users#profile', as: 'user_profile'

  devise_scope :user do
    get '/store' => 'registrations#store'
    post '/store' => 'registrations#store_confirm'
    put '/store' => 'registrations#store_redeem'

    get '/login' => 'users#login_page', as: 'custom_login'
    get '/sign_up' => redirect('/login#sign_up')
    # post '/login' => 'users#login'
  end
 

  # static pages
  get '/welcome' => 'application#welcome', as: 'welcome_index'
  get '/companies' => 'application#companies'

  get '/ourgames' => 'application#ourgames'
  get '/about' => 'application#about'
  get '/about_us' => 'application#about'

  get '/private-policy' => 'application#private_policy'

  get '/home' => 'application#landing_page'


  get '/games' => 'application#games'
  post '/mail' => 'application#mail'


  mount Thredded::Engine => '/forum'
  mount Monologue::Engine => '/blog'

  Monologue::Engine.routes.draw do
    get '/login' => redirect('/blog/monologue/login')
  end


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
