Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :api do
    namespace :v1 do
      # Users resource routes
      get 'users/list', to: 'users#index'
      get 'users/:id', to: 'users#show'
      post 'users/:id', to: 'users#create'
      put 'users/:id', to: 'users#update'
      delete 'users/:id', to: 'users#destroy'

      # Posts resource routes
      get 'posts/list', to: 'posts#index'
      get 'posts/:id', to: 'posts#show'
      post 'posts/:id', to: 'posts#create'
      put 'posts/:id', to: 'posts#update'
      delete 'posts/:id', to: 'posts#destroy'

      # Documents resource routes
      get 'documents/list', to: 'documents#index'
      get 'documents/:id', to: 'documents#show'
      post 'documents/:id', to: 'documents#create'
      put 'documents/:id', to: 'documents#update'
      delete 'documents/:id', to: 'documents#destroy'

      # Users resource routes for atomic operations
      post 'users/:id/increment_points', to: 'users#increment_points'
      post 'users/:id/decrement_points', to: 'users#decrement_points'

      # Posts resource routes for atomic operations
      post 'posts/:id/append_content', to: 'posts#append_content'
      post 'posts/:id/prepend_content', to: 'posts#prepend_content'

      # Documents resource routes for atomic operations
      post 'documents/:id/touch_document', to: 'documents#touch_document'

      # Airlines resource routes
      get 'airlines/list', to: 'airlines#index'
      get 'airlines/to-airport', to: 'airlines#to_airport'
      get 'airlines/:id', to: 'airlines#show'
      post 'airlines/:id', to: 'airlines#create'
      put 'airlines/:id', to: 'airlines#update'
      delete 'airlines/:id', to: 'airlines#destroy'

      # Airports resource routes
      get 'airports/list', to: 'airports#index'
      get 'airports/direct-connections', to: 'airports#direct_connections'
      get 'airports/:id', to: 'airports#show'
      post 'airports/:id', to: 'airports#create'
      put 'airports/:id', to: 'airports#update'
      delete 'airports/:id', to: 'airports#destroy'

      # Routes resource routes
      get 'routes/list', to: 'routes#index'
      get 'routes/:id', to: 'routes#show'
      post 'routes/:id', to: 'routes#create'
      put 'routes/:id', to: 'routes#update'
      delete 'routes/:id', to: 'routes#destroy'

      # Hotel
      get 'hotels/list', to: 'hotels#index'
      get 'hotels/:id', to: 'hotels#show'
      post 'hotels/:id', to: 'hotels#create'
      put 'hotels/:id', to: 'hotels#update'
      delete 'hotels/:id', to: 'hotels#destroy'
      get 'hotels/find_by_id', to: 'hotels#find_hotel_by_id'
      get 'hotels/find_by_name', to: 'hotels#find_hotel_by_name'
      get 'hotels/active_hotels', to: 'hotels#active_hotels'
      get 'hotels/find_by_name_and_price', to: 'hotels#find_hotels_by_name_and_price'
      get 'hotels/find_by_email_domain', to: 'hotels#find_hotels_by_email_domain'
      get '/hotels/create_and_update', to: 'hotels#create_and_update'

      # n1ql
      get '/hotels/find_by_name_n1ql', to: 'hotels#find_hotels_by_name_n1ql'
    end
  end
end
