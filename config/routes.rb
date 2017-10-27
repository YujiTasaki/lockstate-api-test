Rails.application.routes.draw do
  
  get 'callapi/getaccessuser'
  post 'callapi/getaccessuser'
  
  get 'callapi/getaccount'
  post 'callapi/getaccount'
  
  get 'callapi/getdevice'
  post 'callapi/getdevice'
  
  get 'callapi/getevent'
  post 'callapi/getevent'
  
  get 'callapi/getgroup'
  post 'callapi/getgroup'
  
  get 'callapi/getlocation'
  post 'callapi/getlocation'
  
  get 'callapi/getmodel'
  post 'callapi/getmodel'
  
  get 'callapi/getsubscribers'
  post 'callapi/getsubscribers'
  
  root 'aouthsetup#setup'
  
  get 'aouthsetup/setup'
  post 'aouthsetup/setup'
  
  get 'aouthsetup/callback'
  post 'aouthsetup/callback'

  get 'aouthsetup/getcode'
  post 'aouthsetup/getcode'
  
  get 'callapi/createUser'
  post 'callapi/createUser'
  
  get 'callapi/getsubscriptions'
  post 'callapi/getsubscriptions'
  
  get 'callapi/getschedules'
  post 'callapi/getschedules'
  
  get 'callapi/getuser'
  post 'callapi/getuser'
  
  get 'callapi/getaccessexception'
  post 'callapi/getaccessexception'
  
  get 'callapi/errors'
  post 'callapi/errors'
  
  get 'callapi/getacs'
  post 'callapi/getacs'
  
  
  
  
  get 'aouthsetup/setup'

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
