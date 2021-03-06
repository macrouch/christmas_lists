Rails.application.routes.draw do
  delete 'user_notifications/destroy'

  post '/auth/:provider/callback' => 'sessions#create'
  get 'activate/:token' => 'users#activate', as: :user_activation
  get '/auth/:provider/callback' => 'sessions#create'
  get '/auth/failure' => 'sessions#failure'
  get '/logout' => 'sessions#destroy', as: :logout
  get 'join_group/:id' => 'groups#join', as: :join_group
  get 'group/:group_id/remove_group_member/:member_id' => 'groups#remove_member', as: :remove_group_member
  post 'join_group/:id' => 'users#join_group'
  get 'leave_group/:id' => 'users#leave_group', as: :leave_group
  post 'group_invite' => 'groups#invite', as: :group_invite
  get 'draw_names/:id' => 'groups#draw_names', as: :draw_names
  post 'draw_names/:id' => 'groups#do_draw_names', as: :do_draw_names
  post 'save_sub_groups/:id' => 'groups#save_sub_groups', as: :save_sub_groups
  post 'create_next_collection/:id' => 'groups#create_next_collection', as: :create_next_collection

  resources :users, only: [:edit, :update]
  resources :identities
  resources :item_comments, only: [:create]
  resources :groups
  resources :collections do
    resources :lists do
      resources :items, only: [:new, :edit, :update, :create, :destroy]
    end
  end
  resources :password_resets

  root 'sessions#index'

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
