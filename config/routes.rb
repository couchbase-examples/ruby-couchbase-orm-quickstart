Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :api do
    namespace :v1 do
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
      # get 'hotels/list', to: 'hotels#index'
      # get 'hotels/:id', to: 'hotels#show'
      # post 'hotels/:id', to: 'hotels#create'
      # put 'hotels/:id', to: 'hotels#update'
      # delete 'hotels/:id', to: 'hotels#destroy'
      # get 'hotels/find_by_id', to: 'hotels#find_hotel_by_id'
      # get 'hotels/find_by_name', to: 'hotels#find_hotel_by_name'
      # get 'hotels/active_hotels', to: 'hotels#active_hotels'
      # get 'hotels/find_by_name_and_price', to: 'hotels#find_hotels_by_name_and_price'
      # get 'hotels/find_by_email_domain', to: 'hotels#find_hotels_by_email_domain'
      # get '/hotels/create_and_update', to: 'hotels#create_and_update'

      # n1ql
      get '/hotels/find_by_name_n1ql', to: 'hotels#find_hotels_by_name_n1ql'
    end
  end
end
